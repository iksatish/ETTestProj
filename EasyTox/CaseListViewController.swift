//
//  CaseListViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

enum SortType:String{
    case CaseNO = "Case Accession"
    case FirstName = "First Name"
    case LastName = "Last Name"
    case DOB = "Date of Birth"
    case DateCollected = "Date Collected"
    case MdRecNo = "Med. Record No"
    case Status = "Case Status"
    static let allValues = [CaseNO, FirstName, LastName, DOB, DateCollected, MdRecNo, Status]
    
    init?(id : Int) {
        switch id {
        case 1:
            self = .CaseNO
        case 2:
            self = .FirstName
        case 3:
            self = .LastName
        case 4:
            self = .DOB
        case 5:
            self = .DateCollected
        case 6:
            self = .MdRecNo
        case 7:
            self = .Status
        default:
            return nil
        }
    }
}

class CaseListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SortByDelegate {

    var caseListData : NSMutableArray?
    var actualCaseData : NSMutableArray?
    @IBOutlet weak var tableView: UITableView!
    var isFetchInProgress = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let _ = defaults.object(forKey: "EX-Token") , !self.isFetchInProgress{
            self.getCaseList()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(CaseListViewController.fetchCaseList(_:)), name: NSNotification.Name(rawValue: kFetchListNotification), object: nil)
        self.caseListData = NSMutableArray()
        self.actualCaseData = NSMutableArray()
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier:"listCellIdentifier")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caseListData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listCellIdentifier")! as! ListTableViewCell
        if (indexPath as NSIndexPath).row != 0 {
            cell.caseForm = caseListData![(indexPath as NSIndexPath).row-1] as? CaseFormSimplified
        }
        cell.setupData((indexPath as NSIndexPath).row)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func reloadTableWithData(_ array:NSMutableArray){
        let tableData = NSMutableArray()
//        if self.tabBarItem.title = "Pending Orders"{
//            
//        }
        for data in array{
            let caseForm = data as? CaseForm
            let caseFormSimpl = CaseFormSimplified()
            caseFormSimpl.caseAccession = (caseForm?.caseAccession)!
            if self.tabBarItem.tag == 3 && caseForm?.statusFlag != "pending"{
                continue
            }
            let insuranceType = caseForm!.insuranceType
            var physician = UserObject()
            if insuranceType == "Primary" {
                physician = caseForm!.primaryPhysician!.user!
            }else if insuranceType == "Secondary"{
                physician = caseForm!.secondaryPhysician!.user!
            }else{
                physician = caseForm!.ccPhysician!.user!
            }
            if let fname = physician.firstName{
                caseFormSimpl.firstName = "\(fname)" as NSString
            }
            if let lname = physician.lastName{
                caseFormSimpl.lastName = "\(lname)" as NSString
            }
            caseFormSimpl.medRecNo = (caseForm?.medRecNo)!
            caseFormSimpl.dob = "24/Mar/1999"
            caseFormSimpl.dateCollected = caseForm!.dateCollected!
            caseFormSimpl.statusFlag = (caseForm?.statusFlag)!
            tableData.add(caseFormSimpl)
        }
        self.actualCaseData = array
        self.caseListData = tableData
        
        self.tableView.reloadData()
    }
    
    @IBAction func onTappingSortBy(_ sender: UIButton) {
        let sortByVC = self.storyboard?.instantiateViewController(withIdentifier: "SortByVcId") as! SortByTableViewController
        sortByVC.modalPresentationStyle = .popover
        sortByVC.preferredContentSize = CGSize(width: 160, height: 320)
        sortByVC.popoverPresentationController?.sourceView = sender
        sortByVC.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.origin.x, y: sender.center.y, width: 1, height: 1)
        sortByVC.delegate = self
        self.present(sortByVC, animated: true, completion: nil)
    }
    
    func sortBy(_ type: SortType) {
        let sortedArray = self.caseListData!.sortedArray (comparator: {
            (obj1, obj2) -> ComparisonResult in
            
            let p1 = obj1 as! CaseFormSimplified
            let p2 = obj2 as! CaseFormSimplified
            
            let key = self.getSortKey(type)
            if type == .DateCollected{
                return (p2.value(forKey: key) as! Date).compare(p1.value(forKey: key) as! Date)
            }else{
                return (p2.value(forKey: key) as! String).caseInsensitiveCompare(p1.value(forKey: key) as! String)
            }
        })
        self.caseListData = NSMutableArray(array: sortedArray)
//        let arrayData = self.caseListData
//        self.caseListData = self.caseListData!.sort { ($0.caseAccession as! String) > $1.caseAccession as! String)
        self.tableView.reloadData()
    }
   
    func getSortKey(_ type:SortType) -> String{
        switch type{
        case .CaseNO:
            return "caseAccession"
        case .FirstName:
            return "firstName"
        case .LastName:
            return "lastName"
        case .DOB:
            return "dob"
        case .DateCollected:
            return "dateCollected"
        case .MdRecNo:
            return "medRecNo"
        case .Status:
            return "statusFlag"
        }
    }
    
    func getCaseList(){
        isFetchInProgress = true
        let ser = ServiceRequest()
        let defaults = UserDefaults.standard
        let req = NSMutableURLRequest(url: URL(string: "http://bmtechsol.com:8080/easytox/api/caseOrder")!)
        req.httpMethod  = "GET"
        req.setValue("Bearer \(defaults.value(forKey: "EX-Token")!)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.showProgressView("Fetching Case List")
        ser.doServiceRequest(req as URLRequest, failure: { (error) in
            print(error)
            DispatchQueue.main.sync(execute: {
                if let loginStatus = error?.value(forKey: "loginStatus") as? String , loginStatus == "failed"{
                    let tabbarVC = self.tabBarController as! HomeTabBarViewController
                    tabbarVC.forceLogin()
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: "EX-Token")
                    defaults.synchronize()
                    
                }
                self.isFetchInProgress = false
                self.hideProgressView()
            })
            }, success: { (data) in
                self.isFetchInProgress = false
                DispatchQueue.main.sync(execute: {
                    self.hideProgressView()
                    if let jsonData = data?.value(forKey: "jsonData") as? NSArray{
                        self.processData(jsonData)                    }
                    
                })
        })
        
    }
    
    func processData(_ dataDict : NSArray){
        let dataArray = NSMutableArray()
        for data in dataDict {
            
            //            if let _ = data{
            let form = CaseForm()
            form.caseOrderId = (data as AnyObject).value(forKey: "caseOrderID") as? NSInteger
            form.caseNo = (data as AnyObject).value(forKey: "caseNo") as? NSString
            form.caseAccession = (data as AnyObject).value(forKey: "caseAccession") as? NSString
            form.dateReceived = (data as AnyObject).value(forKey: "dateReceived") as? Date
            form.dateCollected = Util.dateFor((data as AnyObject).value(forKey: "dateCollected") as! String)
            if let phyData = (data as AnyObject).value(forKey: "primaryPhysician"){
                let physician = Physician()
                physician.phyId = (phyData as AnyObject).value(forKey: "id") as? NSInteger
                physician.medicare_num = (phyData as AnyObject).value(forKey: "medicare_num") as? NSString
                physician.medicaid_num = (phyData as AnyObject).value(forKey: "medicaid_num") as? NSString
                physician.upin_num = (phyData as AnyObject).value(forKey: "upin_num") as? NSString
                physician.state_license = (phyData as AnyObject).value(forKey: "state_license") as? NSString
                physician.created_by = (phyData as AnyObject).value(forKey: "created_by") as? NSString
                physician.created_date = (phyData as AnyObject).value(forKey: "created_date") as? Date
                physician.modified_by = (phyData as AnyObject).value(forKey: "modified_by") as? NSString
                physician.modified_date = (phyData as AnyObject).value(forKey: "modified_date") as? Date
                if let user = (phyData as AnyObject).value(forKey: "user"){
                    let userObj = UserObject()
                    userObj.id = (user as AnyObject).value(forKey: "id") as? NSInteger
                    userObj.username = (user as AnyObject).value(forKey: "username") as? NSString
                    userObj.firstName = (user as AnyObject).value(forKey: "firstName") as? NSString
                    userObj.lastName = (user as AnyObject).value(forKey: "lastName") as? NSString
                    userObj.email = (user as AnyObject).value(forKey: "email") as? NSString
                    userObj.userType = (user as AnyObject).value(forKey: "userType") as? NSString
                    userObj.contact = (user as AnyObject).value(forKey: "contact") as? NSString
                    userObj.createdBy = (user as AnyObject).value(forKey: "createdBy") as? NSString
                    userObj.createdDate = (user as AnyObject).value(forKey: "createdDate") as? Date
                    userObj.modifiedBy = (user as AnyObject).value(forKey: "modifiedBy") as? NSString
                    userObj.modifiedDate = (user as AnyObject).value(forKey: "modifiedDate") as? Date
                    physician.user = userObj
                }
                form.primaryPhysician = physician
            }
            if let phyData = (data as AnyObject).value(forKey: "secondaryPhysician"){
                let physician = Physician()
                physician.phyId = (phyData as AnyObject).value(forKey: "id") as? NSInteger
                physician.medicare_num = (phyData as AnyObject).value(forKey: "medicare_num") as? NSString
                physician.medicaid_num = (phyData as AnyObject).value(forKey: "medicaid_num") as? NSString
                physician.upin_num = (phyData as AnyObject).value(forKey: "upin_num") as? NSString
                physician.state_license = (phyData as AnyObject).value(forKey: "state_license") as? NSString
                physician.created_by = (phyData as AnyObject).value(forKey: "created_by") as? NSString
                physician.created_date = (phyData as AnyObject).value(forKey: "created_date") as? Date
                physician.modified_by = (phyData as AnyObject).value(forKey: "modified_by") as? NSString
                physician.modified_date = (phyData as AnyObject).value(forKey: "modified_date") as? Date
                if let user = (phyData as AnyObject).value(forKey: "user"){
                    let userObj = UserObject()
                    userObj.id = (user as AnyObject).value(forKey: "id") as? NSInteger
                    userObj.username = (user as AnyObject).value(forKey: "username") as? NSString
                    userObj.firstName = (user as AnyObject).value(forKey: "firstName") as? NSString
                    userObj.lastName = (user as AnyObject).value(forKey: "lastName") as? NSString
                    userObj.email = (user as AnyObject).value(forKey: "email") as? NSString
                    userObj.userType = (user as AnyObject).value(forKey: "userType") as? NSString
                    userObj.contact = (user as AnyObject).value(forKey: "contact") as? NSString
                    userObj.createdBy = (user as AnyObject).value(forKey: "createdBy") as? NSString
                    userObj.createdDate = (user as AnyObject).value(forKey: "createdDate") as? Date
                    userObj.modifiedBy = (user as AnyObject).value(forKey: "modifiedBy") as? NSString
                    userObj.modifiedDate = (user as AnyObject).value(forKey: "modifiedDate") as? Date
                    physician.user = userObj
                }
                form.secondaryPhysician = physician
            }
            if let phyData = (data as AnyObject).value(forKey: "ccPhysician"){
                let physician = Physician()
                physician.phyId = (phyData as AnyObject).value(forKey: "id") as? NSInteger
                physician.medicare_num = (phyData as AnyObject).value(forKey: "medicare_num") as? NSString
                physician.medicaid_num = (phyData as AnyObject).value(forKey: "medicaid_num") as? NSString
                physician.upin_num = (phyData as AnyObject).value(forKey: "upin_num") as? NSString
                physician.state_license = (phyData as AnyObject).value(forKey: "state_license") as? NSString
                physician.created_by = (phyData as AnyObject).value(forKey: "created_by") as? NSString
                physician.created_date = (phyData as AnyObject).value(forKey: "created_date") as? Date
                physician.modified_by = (phyData as AnyObject).value(forKey: "modified_by") as? NSString
                physician.modified_date = (phyData as AnyObject).value(forKey: "modified_date") as? Date
                if let user = (phyData as AnyObject).value(forKey: "user"){
                    let userObj = UserObject()
                    userObj.id = (user as AnyObject).value(forKey: "id") as? NSInteger
                    userObj.username = (user as AnyObject).value(forKey: "username") as? NSString
                    userObj.firstName = (user as AnyObject).value(forKey: "firstName") as? NSString
                    userObj.lastName = (user as AnyObject).value(forKey: "lastName") as? NSString
                    userObj.email = (user as AnyObject).value(forKey: "email") as? NSString
                    userObj.userType = (user as AnyObject).value(forKey: "userType") as? NSString
                    userObj.contact = (user as AnyObject).value(forKey: "contact") as? NSString
                    userObj.createdBy = (user as AnyObject).value(forKey: "createdBy") as? NSString
                    userObj.createdDate = (user as AnyObject).value(forKey: "createdDate") as? Date
                    userObj.modifiedBy = (user as AnyObject).value(forKey: "modifiedBy") as? NSString
                    userObj.modifiedDate = (user as AnyObject).value(forKey: "modifiedDate") as? Date
                    physician.user = userObj
                }
                form.ccPhysician = physician
            }
            form.medRecNo = (data as AnyObject).value(forKey: "medRecNo") as? NSString
            form.caseType = (data as AnyObject).value(forKey: "caseType") as? NSString
            form.loggedInBy = (data as AnyObject).value(forKey: "loggedInBy") as? NSString
            form.cancelCaseReason = (data as AnyObject).value(forKey: "cancelCaseReason") as? NSString
            form.pathologistID = (data as AnyObject).value(forKey: "pathologistID") as? NSString
            form.insuranceType = (data as AnyObject).value(forKey: "insuranceType") as? NSString
            form.injuryDate = (data as AnyObject).value(forKey: "injuryDate") as? Date
            form.claimNo = (data as AnyObject).value(forKey: "claimNo") as? NSString
            form.statusFlag = (data as AnyObject).value(forKey: "statusFlag") as? NSString
            form.finalizedDate = (data as AnyObject).value(forKey: "finalizedDate") as? Date
            dataArray.add(form)
        }
        self.reloadTableWithData(dataArray)
        
    }
    
    func fetchCaseList(_ sender:NotificationCenter){
        if !self.isFetchInProgress{
            self.getCaseList()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func doLogout(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action) in
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "EX-Token")
            defaults.synchronize()
            let tabbarVC = self.tabBarController as! HomeTabBarViewController
            tabbarVC.forceLogin()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)

        
    }

}
