//
//  AddNewCaseViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/14/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class AddNewCaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailsCellDelegate, PickerFieldViewDelegate, PickerViewCallBackDelegate,SingleFieldCellDelegate, URLSessionDelegate {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var collapsedRows:[Int] = []
    var caseForm = CaseForm()
    var insuranceType:String = ""
    var isNewCase = true
    
    var caseNoTF: UITextField?
    var medRecNoTF: UITextField?
    var dateCollectedTF: UITextField?
    var dateReceivedTF: UITextField?
    var caseTypeTF: UITextField?
    var loggedInByTF: UITextField?
    var prescribedMedicine: UITextField?
    var finalInterpretationTF: UITextField?
    var showOnReportSW: UISwitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "SingleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: singleCellIdentifier)
        self.tableView.register(UINib(nibName: "DoubleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: doubleCellIdentifier)
        self.tableView.register(UINib(nibName: "PatientInfoTableViewCell", bundle: nil), forCellReuseIdentifier: patientInfoCellIdentifier)
        self.tableView.register(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
        let ftview = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 200))
        self.tableView.tableFooterView = ftview
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNewCase{
            let formatter = DateFormatter()
            formatter.dateFormat = "yy"
            let dateStr = formatter.string(from: Date())
            self.caseForm.caseNo = (self.randomString() + dateStr + self.randomNumber()) as NSString
        }
        self.loggedInByTF?.text = UserDefaults.standard.value(forKey: "usr") as? String
        self.tableView.reloadData()
        
    }

    // MARK: Tableview
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 6
        case 1:
            if self.insuranceType == "Worksmen"{
                return 7
            }
            else{
                return 6
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).section{
        case 0:
            if (indexPath as NSIndexPath).row == 0{
                let cell:HeaderCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier)! as! HeaderCellTableViewCell
                cell.cellTitle.text = "Patient Details"
                return cell
            }else if (indexPath as NSIndexPath).row == 1{
                let cell:SingleFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: singleCellIdentifier)! as! SingleFieldTableViewCell
                cell.headerLabel.text = "Patient"
                cell.inputField.placeholder = "Select Patient"
                cell.inputField.setUpField(FieldType.dropdown)
                cell.delegate = self
                cell.pickerDelegate = self
                self.prescribedMedicine = cell.inputField
                return cell
            }else{
                let cell:DoubleFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: doubleCellIdentifier)! as! DoubleFieldTableViewCell
                cell.setUpCell(indexPath, cellFor: patientFormIdentifier)
                cell.delegate = self
                if (indexPath as NSIndexPath).row == 2{
                    self.caseNoTF = cell.firstInputField
                    if let caseNo = caseForm.caseNo as? String{
                        cell.firstInputField.text = caseNo
                    }
                    self.medRecNoTF = cell.secondTextField
                }else if (indexPath as NSIndexPath).row == 3{
                    self.dateCollectedTF = cell.firstInputField
                    self.dateReceivedTF = cell.secondTextField
                }else if (indexPath as NSIndexPath).row == 4{
                    self.caseTypeTF = cell.firstInputField
                    self.loggedInByTF = cell.secondTextField
                }
                return cell
            }
        case 1:
            if (indexPath as NSIndexPath).row == 0{
                let cell:HeaderCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier)! as! HeaderCellTableViewCell
                cell.cellTitle.text = "Physician Details"
               return cell
            }else{
                let cell:DoubleFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: doubleCellIdentifier)! as! DoubleFieldTableViewCell
                cell.setUpCell(indexPath, cellFor: physicianFormIdentifier)
                cell.delegate = self
                if (indexPath as NSIndexPath).row == 4{
                    self.finalInterpretationTF = cell.firstInputField
                    self.showOnReportSW = cell.switchView
                    if let isSwitchedOn = caseForm.showOnReport{
                        cell.switchView.setOn(isSwitchedOn, animated: true)
                    }
                }
                return cell
            }
        default:
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "submitCellIdentifier")! as UITableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath as NSIndexPath).section{
        case 2:
            return 44
        default:
            if (indexPath as NSIndexPath).row == 0{
                return 45
            }else{
                return 85
            }
        }
    }
    
    //MARK: Cell Delegate
    func collapseThisCell(_ rowNum: Int, isCollapsing:Bool) {
        if isCollapsing{
            if self.collapsedRows.index(of: rowNum) == nil{
                self.collapsedRows.append(rowNum)
            }
        }else{
            if let temp = self.collapsedRows.index(of: rowNum){
                self.collapsedRows.remove(at: temp)
            }
        }
        self.tableView.reloadData()

    }
    
    func openPickerViewForField(_ textField: UITextField, forPickerType: PickerViewType) {
        let vc:PickerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pickerViewControllerIdentifier") as! PickerViewController
        vc.pickerViewType = forPickerType
        vc.currentField = textField
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func updateFormWithPickerSelection(_ value: String, forType: PickerViewType) {
        switch forType{
        case .patient:
            self.caseForm.patientId = Int(value)
        case .primaryPhysician:
            self.caseForm.primaryPhysicianId = Int(value)
        case .secondaryPhysician:
            self.caseForm.secondaryPhysicianId = Int(value)
        case .ccPhysician:
            self.caseForm.ccPhysicianId = Int(value)
        case .pathologist:
            self.caseForm.pathologistId = Int(value)
        case .insuranceType:
            self.caseForm.insuranceType = value as NSString?
        case .caseType:
            self.caseForm.caseType = value as NSString?
        default:
            break
        }
        
        
        if forType == .insuranceType{
            self.insuranceType = value
            self.tableView.reloadData()
        }
    }
    
    func openNewPatientView() {
        let vc:NewPatientViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newPatientViewControllerIdentifier") as! NewPatientViewController
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func submitForm(_ sender: UIButton) {
        caseForm.dateReceived = self.dateReceivedTF?.text as NSString?
        caseForm.dateCollected = self.dateCollectedTF?.text as NSString?
        caseForm.medRecNo = self.medRecNoTF?.text as NSString?
        caseForm.loggedInBy = self.loggedInByTF?.text as NSString?
        var dictionary = NSMutableDictionary()
        guard let pid = caseForm.patientId else {
            self.showAlert(title: "", message: "Please select a patient to continue!")
            return
        }
        guard let mrc = caseForm.medRecNo else {
            self.showAlert(title: "", message: "Please enter medical record number to continue!")
            return
        }
        guard let dc = caseForm.dateCollected else {
            self.showAlert(title: "", message: "Please enter date collected to continue!")
            return
        }
        guard let dr = caseForm.dateReceived else {
            self.showAlert(title: "", message: "Please enter date received to continue!")
            return
        }
        guard let ct = caseForm.caseType else {
            self.showAlert(title: "", message: "Please enter case type to continue!")
            return
        }
        guard let ppid = caseForm.primaryPhysicianId else {
            self.showAlert(title: "", message: "Please select primary physician to continue!")
            return
        }
        guard let pdid = caseForm.pathologistId else {
            self.showAlert(title: "", message: "Please select Pathologist to continue!")
            return
        }
        guard let it = caseForm.insuranceType else {
            self.showAlert(title: "", message: "Please select Insurance Type to continue!")
            return
        }
        dictionary.setValue(caseForm.patientId!, forKey: "patient")
        dictionary.setValue(caseForm.caseNo!, forKey: "caseNo")
        dictionary.setValue(dr, forKey: "dateReceived")
        dictionary.setValue(dc, forKey: "dateCollected")
        dictionary.setValue(ppid, forKey: "primaryPhysician")
        dictionary.setValue(mrc, forKey: "medRecNo")
        dictionary.setValue(ct, forKey: "caseType")
        dictionary.setValue(it, forKey: "insuranceType")
        dictionary.setValue(pdid, forKey: "pathologist")
        self.createCase(ddata: dictionary)

    }
    
    func createCase(ddata: NSDictionary){
        guard let resolvedUrl = caseListUrl.addingPercentEscapes(using: String.Encoding.utf8), let url = URL(string: resolvedUrl), let localToken = UserDefaults.standard.value(forKey: "EX-Token") else{
            return
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization" : "Bearer \(localToken)"]
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let request = NSMutableURLRequest(url: url)
        do {
          let requestNSData = try JSONSerialization.data(withJSONObject: ddata, options: [])
            request.httpBody = requestNSData
        }catch{
            return
        }
        self.showProgressView("Creating Case")
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest) {
            (
            data,  response, error) in
            do{
                if let _ = error
                {
                    self.hideProgressView()
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400{
                    self.showLogOutAlert()
                    return
                }
                guard let _ = data, let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [NSString : AnyObject] else
                {
                    self.hideProgressView()
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                }
                DispatchQueue.main.async {
                    self.hideProgressView()
//                    self.checkData(data: jsonData)
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.hideProgressView()
                    self.showAlert(title: "Service Issue", message: "Please try again!")
                    return
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    func checkData(data: NSDictionary){
        if let error = data.value(forKey: "error") as? String{
            self.showAlert(title: "Error!", message: error)
        }
    }
    
    
    func showLogOutAlert(){
        self.hideProgressView()
        let alertController = UIAlertController(title: "Session Timed Out!", message: "Please login again to continue!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Login", style: .cancel, handler:  { action in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let tabBarVC = appDelegate.window?.rootViewController as? HomeTabBarViewController else {return}
            tabBarVC.forceLogin()
        }))
        UserDefaults.standard.removeObject(forKey: "EX-Token")
        self.present(alertController, animated: true, completion: nil)
    }


}
