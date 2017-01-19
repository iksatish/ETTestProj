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

class CaseListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, URLSessionDelegate {

    var caseListData : [CaseFormSimplified]?
    var actualCaseData : [CaseForm]?
    @IBOutlet weak var tableView: UITableView!
    var isFetchInProgress = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let _ = defaults.object(forKey: "EX-Token"), let tabBar = self.tabBarController as? HomeTabBarViewController, !self.isFetchInProgress{
            tabBar.fetchAllData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(CaseListViewController.fetchCaseList(_:)), name: NSNotification.Name(rawValue: kFetchListNotification), object: nil)
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
        guard let _ = self.caseListData else{return 0}
        return caseListData!.count
    }
    override func completeAction(){
        self.reloadTableWithData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let _ = self.caseListData else{return UITableViewCell()}
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
    
    func reloadTableWithData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let tabBarVC = appDelegate.window?.rootViewController as? HomeTabBarViewController else {return}
        self.actualCaseData = tabBarVC.caseList
        var tableData: [CaseFormSimplified] = []
        if let caseData = self.actualCaseData{
            for data in caseData{
                let caseFormSimpl = CaseFormSimplified()

                if self.tabBarItem.tag == 3 && data.statusFlag != "pending"{
                    continue
                }
                caseFormSimpl.caseAccession = "\(data.caseNo!)" as NSString
                
                caseFormSimpl.firstName = "\(data.patientName!)" as NSString
                if let recNO = data.medRecNo{
                    caseFormSimpl.medRecNo = recNO
                }
                caseFormSimpl.dob = "\(data.patientId!)" as NSString
//                caseFormSimpl.dateCollected = data.dateCollected!
                caseFormSimpl.statusFlag = (data.statusFlag)!
                tableData.append(caseFormSimpl)
            }
            self.caseListData = tableData
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func onTappingSortBy(_ sender: UIButton) {
        let sortByVC = self.storyboard?.instantiateViewController(withIdentifier: "SortByVcId") as! SortByTableViewController
        sortByVC.modalPresentationStyle = .popover
        sortByVC.preferredContentSize = CGSize(width: 160, height: 320)
        sortByVC.popoverPresentationController?.sourceView = sender
        sortByVC.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.origin.x, y: sender.center.y, width: 1, height: 1)
//        sortByVC.delegate = self
        self.present(sortByVC, animated: true, completion: nil)
    }
    
//    func sortBy(_ type: SortType) {
//        let sortedArray = self.caseListData!.sortedArray (comparator: {
//            (obj1, obj2) -> ComparisonResult in
//            
//            let p1 = obj1 as! CaseFormSimplified
//            let p2 = obj2 as! CaseFormSimplified
//            
//            let key = self.getSortKey(type)
//            if type == .DateCollected{
//                return (p2.value(forKey: key) as! Date).compare(p1.value(forKey: key) as! Date)
//            }else{
//                return (p2.value(forKey: key) as! String).caseInsensitiveCompare(p1.value(forKey: key) as! String)
//            }
//        })
//        self.caseListData = NSMutableArray(array: sortedArray)
////        let arrayData = self.caseListData
////        self.caseListData = self.caseListData!.sort { ($0.caseAccession as! String) > $1.caseAccession as! String)
//        self.tableView.reloadData()
//    }
   
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

    func fetchCaseList(_ sender:NotificationCenter){
        if let tabBar = self.tabBarController as? HomeTabBarViewController, !self.isFetchInProgress{
            tabBar.fetchAllData()
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

