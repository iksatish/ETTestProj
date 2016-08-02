//
//  CaseListViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

enum SortType{
    case CaseNO
    case FirstName
    case LastName
    case DOB
    case DateCollected
    case MdRecNo
    case Status
}

class CaseListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var caseListData : NSMutableArray?
    var actualCaseData : NSMutableArray?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.caseListData = NSMutableArray()
        self.actualCaseData = NSMutableArray()
        self.tableView.registerNib(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier:"listCellIdentifier")
        self.setupnavBarButton()
    }

    func setupnavBarButton(){
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .Pause, target: self, action: Selector("showSortByType:"))
        leftBarButton.image = UIImage(named: "check")
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func showSortByType(sender:UIBarButtonItem){
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caseListData!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ListTableViewCell = tableView.dequeueReusableCellWithIdentifier("listCellIdentifier")! as! ListTableViewCell
        if indexPath.row != 0 {
            cell.caseForm = caseListData![indexPath.row-1] as? CaseFormSimplified
        }
        cell.setupData(indexPath.row)
        
        return cell

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func reloadTableWithData(array:NSMutableArray?){
        let tableData = NSMutableArray()
        for data in array!{
            let caseForm = data as? CaseForm
            let caseFormSimpl = CaseFormSimplified()
            caseFormSimpl.caseAccession = (caseForm?.caseAccession)!
            
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
                caseFormSimpl.firstName = "\(fname)"
            }
            if let lname = physician.lastName{
                caseFormSimpl.lastName = "\(lname)"
            }
            caseFormSimpl.medRecNo = (caseForm?.medRecNo)!
            caseFormSimpl.dob = "24/Mar/1999"
            caseFormSimpl.dateCollected = caseForm!.dateCollected!
            caseFormSimpl.statusFlag = (caseForm?.statusFlag)!
            tableData.addObject(caseFormSimpl)
        }
        self.actualCaseData = array
        self.caseListData = tableData
        
        self.tableView.reloadData()
    }
    
    @IBAction func onTappingSortBy(sender: UIButton) {
        
    }
    func sortBy(){
        
    }

}
