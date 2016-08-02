//
//  HomeTabBarViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/7/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController,LoginDelegate {
    
    @IBOutlet weak var headerView: UIView!
    var blurEffectView:UIVisualEffectView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = NSUserDefaults.standardUserDefaults().valueForKey("EX-Token"){
            self.getCaseList()
        }else{
            self.forceLogin()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forceLogin(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        blurEffectView!.alpha = 0.0
        view.addSubview(blurEffectView!)
        UIView.animateWithDuration(0.5, animations: {
            self.blurEffectView!.alpha = 0.9
            }, completion: { _ in
                let vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homeviewcontrollerIdentifier") as! ViewController
                vc.delegate = self
                self.presentViewController(vc, animated: true, completion: nil)
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
        self.getCaseList()
    }
    
    func getCaseList(){
        let ser = ServiceRequest()
        let defaults = NSUserDefaults.standardUserDefaults()
        let req = NSMutableURLRequest(URL: NSURL(string: "http://bmtechsol.com:8080/easytox/api/caseOrder")!)
        req.HTTPMethod  = "GET"
        req.setValue("Bearer \(defaults.valueForKey("EX-Token")!)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.showProgressView("Fetching Case List")
        ser.doServiceRequest(req, failure: { (error) in
            print(error)
            dispatch_sync(dispatch_get_main_queue(), {
                if let loginStatus = error?.valueForKey("loginStatus") as? String where loginStatus == "failed"{
                    self.forceLogin()
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.removeObjectForKey("EX-Token")
                    defaults.synchronize()

                }
                self.hideProgressView()
            })
            }, success: { (data) in
                dispatch_sync(dispatch_get_main_queue(), {
                    self.hideProgressView()
                    if let jsonData = data?.valueForKey("jsonData") as? NSArray{
                        self.processData(jsonData)                    }
                    
                })
        })
        
    }
    
    func processData(dataDict : NSArray){
        let dataArray = NSMutableArray()
        for data in dataDict {
            
            //            if let _ = data{
            let form = CaseForm()
            form.caseOrderId = data.valueForKey("caseOrderID") as? NSInteger
            form.caseNo = data.valueForKey("caseNo") as? NSString
            form.caseAccession = data.valueForKey("caseAccession") as? NSString
            form.dateReceived = data.valueForKey("dateReceived") as? NSDate
            form.dateCollected = Util.dateFor(data.valueForKey("dateCollected") as! String)
            if let phyData = data.valueForKey("primaryPhysician"){
                let physician = Physician()
                physician.phyId = phyData.valueForKey("id") as? NSInteger
                physician.medicare_num = phyData.valueForKey("medicare_num") as? NSString
                physician.medicaid_num = phyData.valueForKey("medicaid_num") as? NSString
                physician.upin_num = phyData.valueForKey("upin_num") as? NSString
                physician.state_license = phyData.valueForKey("state_license") as? NSString
                physician.created_by = phyData.valueForKey("created_by") as? NSString
                physician.created_date = phyData.valueForKey("created_date") as? NSDate
                physician.modified_by = phyData.valueForKey("modified_by") as? NSString
                physician.modified_date = phyData.valueForKey("modified_date") as? NSDate
                if let user = phyData.valueForKey("user"){
                    let userObj = UserObject()
                    userObj.id = user.valueForKey("id") as? NSInteger
                    userObj.username = user.valueForKey("username") as? NSString
                    userObj.firstName = user.valueForKey("firstName") as? NSString
                    userObj.lastName = user.valueForKey("lastName") as? NSString
                    userObj.email = user.valueForKey("email") as? NSString
                    userObj.userType = user.valueForKey("userType") as? NSString
                    userObj.contact = user.valueForKey("contact") as? NSString
                    userObj.createdBy = user.valueForKey("createdBy") as? NSString
                    userObj.createdDate = user.valueForKey("createdDate") as? NSDate
                    userObj.modifiedBy = user.valueForKey("modifiedBy") as? NSString
                    userObj.modifiedDate = user.valueForKey("modifiedDate") as? NSDate
                    physician.user = userObj
                }
                form.primaryPhysician = physician
            }
            if let phyData = data.valueForKey("secondaryPhysician"){
                let physician = Physician()
                physician.phyId = phyData.valueForKey("id") as? NSInteger
                physician.medicare_num = phyData.valueForKey("medicare_num") as? NSString
                physician.medicaid_num = phyData.valueForKey("medicaid_num") as? NSString
                physician.upin_num = phyData.valueForKey("upin_num") as? NSString
                physician.state_license = phyData.valueForKey("state_license") as? NSString
                physician.created_by = phyData.valueForKey("created_by") as? NSString
                physician.created_date = phyData.valueForKey("created_date") as? NSDate
                physician.modified_by = phyData.valueForKey("modified_by") as? NSString
                physician.modified_date = phyData.valueForKey("modified_date") as? NSDate
                if let user = phyData.valueForKey("user"){
                    let userObj = UserObject()
                    userObj.id = user.valueForKey("id") as? NSInteger
                    userObj.username = user.valueForKey("username") as? NSString
                    userObj.firstName = user.valueForKey("firstName") as? NSString
                    userObj.lastName = user.valueForKey("lastName") as? NSString
                    userObj.email = user.valueForKey("email") as? NSString
                    userObj.userType = user.valueForKey("userType") as? NSString
                    userObj.contact = user.valueForKey("contact") as? NSString
                    userObj.createdBy = user.valueForKey("createdBy") as? NSString
                    userObj.createdDate = user.valueForKey("createdDate") as? NSDate
                    userObj.modifiedBy = user.valueForKey("modifiedBy") as? NSString
                    userObj.modifiedDate = user.valueForKey("modifiedDate") as? NSDate
                    physician.user = userObj
                }
                form.secondaryPhysician = physician
            }
            if let phyData = data.valueForKey("ccPhysician"){
                let physician = Physician()
                physician.phyId = phyData.valueForKey("id") as? NSInteger
                physician.medicare_num = phyData.valueForKey("medicare_num") as? NSString
                physician.medicaid_num = phyData.valueForKey("medicaid_num") as? NSString
                physician.upin_num = phyData.valueForKey("upin_num") as? NSString
                physician.state_license = phyData.valueForKey("state_license") as? NSString
                physician.created_by = phyData.valueForKey("created_by") as? NSString
                physician.created_date = phyData.valueForKey("created_date") as? NSDate
                physician.modified_by = phyData.valueForKey("modified_by") as? NSString
                physician.modified_date = phyData.valueForKey("modified_date") as? NSDate
                if let user = phyData.valueForKey("user"){
                    let userObj = UserObject()
                    userObj.id = user.valueForKey("id") as? NSInteger
                    userObj.username = user.valueForKey("username") as? NSString
                    userObj.firstName = user.valueForKey("firstName") as? NSString
                    userObj.lastName = user.valueForKey("lastName") as? NSString
                    userObj.email = user.valueForKey("email") as? NSString
                    userObj.userType = user.valueForKey("userType") as? NSString
                    userObj.contact = user.valueForKey("contact") as? NSString
                    userObj.createdBy = user.valueForKey("createdBy") as? NSString
                    userObj.createdDate = user.valueForKey("createdDate") as? NSDate
                    userObj.modifiedBy = user.valueForKey("modifiedBy") as? NSString
                    userObj.modifiedDate = user.valueForKey("modifiedDate") as? NSDate
                    physician.user = userObj
                }
                form.ccPhysician = physician
            }
            form.medRecNo = data.valueForKey("medRecNo") as? NSString
            form.caseType = data.valueForKey("caseType") as? NSString
            form.loggedInBy = data.valueForKey("loggedInBy") as? NSString
            form.cancelCaseReason = data.valueForKey("cancelCaseReason") as? NSString
            form.pathologistID = data.valueForKey("pathologistID") as? NSString
            form.insuranceType = data.valueForKey("insuranceType") as? NSString
            form.injuryDate = data.valueForKey("injuryDate") as? NSDate
            form.claimNo = data.valueForKey("claimNo") as? NSString
            form.statusFlag = data.valueForKey("statusFlag") as? NSString
            form.finalizedDate = data.valueForKey("finalizedDate") as? NSDate
            dataArray.addObject(form)
        }
        self.gatherData(dataArray)
        
    }
    
    func gatherData(array:NSMutableArray){
        let vc = self.viewControllers![0] as? CaseListViewController
        vc?.reloadTableWithData(array)
    }
    
}
