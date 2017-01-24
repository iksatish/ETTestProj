//
//  HomeTabBarViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/7/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController,LoginDelegate, URLSessionDelegate {
    
    @IBOutlet weak var headerView: UIView!
    var isCasesFetched = false, isPatientsFetched = false, isPathologistsFetched = false, isPhysiciansFetched = false
    var blurEffectView:UIVisualEffectView?
    var caseList:[CaseForm]?
    var patientList: [Patient]?
    var physiciansList: [Physician]?
    var pathologistsList: [Pathologist]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserDefaults.standard.value(forKey: "EX-Token"){
            NotificationCenter.default.post(name: Notification.Name(rawValue: kFetchListNotification), object: nil)
        }else{
            self.forceLogin()
        }
    }
    func forceLogin(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView!.alpha = 0.0
        view.addSubview(blurEffectView!)
        UIView.animate(withDuration: 0.5, animations: {
            self.blurEffectView!.alpha = 0.9
            }, completion: { _ in
                let vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeviewcontrollerIdentifier") as! ViewController
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
        })
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , I think the default value is around 50 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.tabBar.frame = tabFrame
    }
    
    func onLogin() {
        if let _ = blurEffectView{
            self.blurEffectView!.removeFromSuperview()
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: kFetchListNotification), object: nil)
    }
    
    override func showAlert(title: String, message: String) {
        self.hideProgressView()
        self.resetFlags()
        super.showAlert(title: title, message: message)
    }
    
    func showLogOutAlert(){
        self.hideProgressView()
        let alertController = UIAlertController(title: "Session Timed Out!", message: "Please login again to continue!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Login", style: .cancel, handler:  { action in
            self.forceLogin()
            }))
        UserDefaults.standard.removeObject(forKey: "EX-Token")
        self.present(alertController, animated: true, completion: nil)
    }
    //ServiceCalls To Get Data
    func fetchAllData(){
        self.showProgressView("Fetching Case List")
        self.getCasesList()
        self.getPatientsList()
        self.getPhysiciansList()
        self.getPathologistList()
    }
    
    
    
    func getCasesList(){
        guard let resolvedUrl = caseListUrl.addingPercentEscapes(using: String.Encoding.utf8), let url = URL(string: resolvedUrl), let localToken = UserDefaults.standard.value(forKey: "EX-Token") else{
            return
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : "Bearer \(localToken)"]
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest) {
            (
            data,  response, error) in
            do{
                if let _ = error
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400{
                    self.showLogOutAlert()
                    return
                }
                guard let _ = data, let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [NSDictionary] else
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }
                DispatchQueue.main.async {
                    self.parseCaseList(data: jsonData)
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    
    func getPathologistList(){
        guard let resolvedUrl = pathologistsUrl.addingPercentEscapes(using: String.Encoding.utf8), let url = URL(string: resolvedUrl), let localToken = UserDefaults.standard.value(forKey: "EX-Token") else{
            return
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : "Bearer \(localToken)"]
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest) {
            (
            data,  response, error) in
            do{
                if let _ = error
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400{
                    self.showLogOutAlert()
                    return
                }
                guard let _ = data, let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [NSDictionary] else
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }
                DispatchQueue.main.async {
                    self.parsePathologistsList(data: jsonData)
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    
    func getPatientsList(){
        guard let resolvedUrl = patientsUrl.addingPercentEscapes(using: String.Encoding.utf8), let url = URL(string: resolvedUrl), let localToken = UserDefaults.standard.value(forKey: "EX-Token") else{
            return
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : "Bearer \(localToken)"]
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest) {
            (
            data,  response, error) in
            do{
                if let _ = error
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400{
                    self.showLogOutAlert()
                    return
                }
                guard let _ = data, let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [NSDictionary] else
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }
                DispatchQueue.main.async {
                    self.parsePatientsList(data: jsonData)
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    func getPhysiciansList(){
        guard let resolvedUrl = physiciansUrl.addingPercentEscapes(using: String.Encoding.utf8), let url = URL(string: resolvedUrl), let localToken = UserDefaults.standard.value(forKey: "EX-Token") else{
            return
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : "Bearer \(localToken)"]
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest) {
            (
            data,  response, error) in
            do{
                if let _ = error
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400{
                    self.showLogOutAlert()
                    return
                }
                guard let _ = data, let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [NSDictionary] else
                {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }
                DispatchQueue.main.async {
                    self.parsePhysiciansList(data: jsonData)
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    
    
    
    
    
    
    
    func parseCaseList(data: [NSDictionary]){
        self.caseList = []
        for dataObj in data{
            let caseForm = CaseForm()
            if let keyValue = dataObj.value(forKey: "id") as? NSInteger{
                caseForm.caseId = keyValue
            }
            if let keyValue = dataObj.value(forKey: "caseNo") as? NSString{
                caseForm.caseNo = keyValue
            }
            if let keyValue = dataObj.value(forKey: "patientId") as? NSInteger{
                caseForm.patientId = keyValue
            }
            if let keyValue = dataObj.value(forKey: "patientName") as? NSString{
                caseForm.patientName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medRecNo") as? NSString{
                caseForm.medRecNo = keyValue
            }
            if let keyValue = dataObj.value(forKey: "caseType") as? NSString{
                caseForm.caseType = keyValue
            }
            if let keyValue = dataObj.value(forKey: "dateReceived") as? NSString{
                caseForm.dateReceived = keyValue
            }
            if let keyValue = dataObj.value(forKey: "dateCollected") as? NSString{
                caseForm.dateCollected = keyValue
            }
            if let keyValue = dataObj.value(forKey: "primaryPhysicianId") as? NSInteger{
                caseForm.primaryPhysicianId = keyValue
            }
            if let keyValue = dataObj.value(forKey: "primaryPhysicianName") as? NSString{
                caseForm.primaryPhysicianName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "physicianLocation") as? NSString{
                caseForm.physicianLocation = keyValue
            }
            if let keyValue = dataObj.value(forKey: "secondaryPhysician") as? NSString{
                caseForm.secondaryPhysician = keyValue
            }
            if let keyValue = dataObj.value(forKey: "ccPhysician") as? NSString{
                caseForm.ccPhysician = keyValue
            }
            if let keyValue = dataObj.value(forKey: "loggedInBy") as? NSString{
                caseForm.loggedInBy = keyValue
            }
            if let keyValue = dataObj.value(forKey: "cancelCaseReason") as? NSString{
                caseForm.cancelCaseReason = keyValue
            }
            if let keyValue = dataObj.value(forKey: "insuranceType") as? NSString{
                caseForm.insuranceType = keyValue
            }
            if let keyValue = dataObj.value(forKey: "profile") as? NSString{
                caseForm.profile = keyValue
            }
            if let keyValue = dataObj.value(forKey: "statusFlag") as? NSString{
                caseForm.statusFlag = keyValue
            }
            if let keyValue = dataObj.value(forKey: "finalizedDate") as? NSString{
                caseForm.finalizedDate = keyValue
            }
            if let keyValue = dataObj.value(forKey: "isCorrection") as? Bool{
                caseForm.isCorrection = keyValue
            }
            if let keyValue = dataObj.value(forKey: "isRevision") as? Bool{
                caseForm.isRevision = keyValue
            }
            if let keyValue = dataObj.value(forKey: "isAmended") as? Bool{
                caseForm.isAmended = keyValue
            }
            if let keyValue = dataObj.value(forKey: "amendedCaseOrderID") as? NSInteger{
                caseForm.amendedCaseOrderID = keyValue
            }
            if let keyValue = dataObj.value(forKey: "dateCreated") as? NSString{
                caseForm.dateCreated = keyValue
            }
            if let keyValue = dataObj.value(forKey: "lastUpdated") as? NSString{
                caseForm.lastUpdated = keyValue
            }
            if let keyValue = dataObj.value(forKey: "finalInterpretation") as? NSString{
                caseForm.finalInterpretation = keyValue
            }
            if let keyValue = dataObj.value(forKey: "showOnReport") as? Bool{
                caseForm.showOnReport = keyValue
            }
            self.caseList?.append(caseForm)
        }
        
        
        self.isCasesFetched = true
        self.downloadingCompleted()
    }
    
    func parsePhysiciansList(data: [NSDictionary]){
        self.physiciansList = []
        for dataObj in data{
            let physician = Physician()
            if let keyValue = dataObj.value(forKey: "id") as? NSInteger{
                physician.phyId = keyValue
            }
            if let keyValue = dataObj.value(forKey: "firstName") as? NSString{
                physician.firstName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "middleIntial") as? NSString{
                physician.middleInitial = keyValue
            }
            if let keyValue = dataObj.value(forKey: "lastName") as? NSString{
                physician.lastName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medicalDegree") as? NSString{
                physician.medicalDegree = keyValue
            }
            if let keyValue = dataObj.value(forKey: "contact") as? NSString{
                physician.contactNumber = keyValue
            }
            if let keyValue = dataObj.value(forKey: "salutation") as? NSString{
                physician.salutation = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medicare_num") as? NSString{
                physician.medicare_num = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medicaid_num") as? NSString{
                physician.medicaid_num = keyValue
            }
            self.physiciansList?.append(physician)
        }
        self.isPhysiciansFetched = true
        self.downloadingCompleted()
    }
    
    func parsePatientsList(data: [NSDictionary]){
        self.patientList = []
        for dataObj in data{
            let patient = Patient()
            if let keyValue = dataObj.value(forKey: "id") as? NSInteger{
                patient.patientId = keyValue
            }
            if let keyValue = dataObj.value(forKey: "firstname") as? NSString{
                patient.firstName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "middleInitial") as? NSString{
                patient.middleInitial = keyValue
            }
            if let keyValue = dataObj.value(forKey: "lastname") as? NSString{
                patient.lastName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "gender") as? NSString{
                patient.gender = keyValue
            }
            if let keyValue = dataObj.value(forKey: "age") as? NSInteger{
                patient.age = keyValue
            }
            if let keyValue = dataObj.value(forKey: "contactNumber") as? NSString{
                patient.contactNumber = keyValue
            }
            if let keyValue = dataObj.value(forKey: "workNumber") as? NSString{
                patient.workNumber = keyValue
            }
            if let keyValue = dataObj.value(forKey: "dateOfBirth") as? NSString{
                patient.dateOfBirth = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medRecNo") as? NSString{
                patient.medRecNo = keyValue
            }
            if let keyValue = dataObj.value(forKey: "email") as? NSString{
                patient.email = keyValue
            }
            if let keyValue = dataObj.value(forKey: "insurances") as? [NSDictionary]{
                patient.insurances = []
                for insObj in keyValue{
                    let insurance = Insurance()
                    if let insValue = dataObj.value(forKey: "insuranceType") as? NSString{
                        insurance.insuranceType = insValue
                    }
                    if let insValue = dataObj.value(forKey: "insuranceCompanyCode") as? NSString{
                        insurance.insuranceCompanyCode = insValue
                    }
                    if let insValue = dataObj.value(forKey: "insuranceCompanyName") as? NSString{
                        insurance.insuranceCompanyName = insValue
                    }
                    if let insValue = dataObj.value(forKey: "relation") as? NSString{
                        insurance.relation = insValue
                    }
                    if let insValue = dataObj.value(forKey: "policyID") as? NSString{
                        insurance.policyID = insValue
                    }
                    if let insValue = dataObj.value(forKey: "groupName") as? NSString{
                        insurance.groupName = insValue
                    }
                    if let insValue = dataObj.value(forKey: "groupNumber") as? NSString{
                        insurance.groupNumber = insValue
                    }
                    if let insValue = dataObj.value(forKey: "validityOfPolicy") as? NSString{
                        insurance.validityOfPolicy = insValue
                    }
                    if let insValue = dataObj.value(forKey: "insuredName") as? NSString{
                        insurance.insuredName = insValue
                    }
                    patient.insurances?.append(insurance)
                }
            }
            self.patientList?.append(patient)
        }

        self.isPatientsFetched = true
        self.downloadingCompleted()
    }
    
    func parsePathologistsList(data: [NSDictionary]){
        self.pathologistsList = []
        for dataObj in data{
            let pathologist = Pathologist()
            if let keyValue = dataObj.value(forKey: "id") as? NSInteger{
                pathologist.pathId = keyValue
            }
            if let keyValue = dataObj.value(forKey: "firstName") as? NSString{
                pathologist.firstName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "middleIntial") as? NSString{
                pathologist.middleInitial = keyValue
            }
            if let keyValue = dataObj.value(forKey: "lastName") as? NSString{
                pathologist.lastName = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medicalDegree") as? NSString{
                pathologist.medicalDegree = keyValue
            }
            if let keyValue = dataObj.value(forKey: "contact") as? NSString{
                pathologist.contactNumber = keyValue
            }
            if let keyValue = dataObj.value(forKey: "salutation") as? NSString{
                pathologist.salutation = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medicare_num") as? NSString{
                pathologist.medicare_num = keyValue
            }
            if let keyValue = dataObj.value(forKey: "medicaid_num") as? NSString{
                pathologist.medicaid_num = keyValue
            }
            self.pathologistsList?.append(pathologist)
        }

        
        self.isPathologistsFetched = true
        self.downloadingCompleted()
    }
    

    func downloadingCompleted(){
        if isCasesFetched && isPatientsFetched && isPathologistsFetched && isPhysiciansFetched{
            self.resetFlags()
            self.hideProgressView()
            if let selectedVC = self.selectedViewController as? BaseViewController{
                selectedVC.completeAction()
            }
        }
    }
    
    func resetFlags(){
        isCasesFetched = false
        isPatientsFetched = false
        isPathologistsFetched = false
        isPhysiciansFetched = false
    }
}
