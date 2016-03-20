//
//  AddNewCaseViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/14/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class AddNewCaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var collapsedRows:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "PatientDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "patientDetailsCellIdentifier")
        self.tableView.registerNib(UINib(nibName: "PhysicistTableViewCell", bundle: nil), forCellReuseIdentifier: "physicistCellIdentifier")
        self.tableView.registerNib(UINib(nibName: "PatientInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "headerCellIdentifier")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Tableview
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell:PatientInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("headerCellIdentifier")! as! PatientInfoTableViewCell
            return cell
        }else if indexPath.section == 1{
            let cell:PatientDetailsTableViewCell = tableView.dequeueReusableCellWithIdentifier("patientDetailsCellIdentifier")! as! PatientDetailsTableViewCell
            cell.delegate = self
            cell.rowNum = indexPath.section
            cell.detailsView.hidden = cell.isCollapsed
            return cell
        }else if indexPath.section == 2{
            let cell:PhysicistTableViewCell = tableView.dequeueReusableCellWithIdentifier("physicistCellIdentifier")! as! PhysicistTableViewCell
            cell.delegate = self
            cell.rowNum = indexPath.section
            cell.detalisView.hidden = cell.isCollapsed
            return cell
        }else{
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("submitCellIdentifier")! as UITableViewCell
             return cell

        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 150
        case 1:
            if let _ = self.collapsedRows.indexOf(indexPath.section){
                return 50
            }else{
                return 500
            }
        case 2:
            if let _ = self.collapsedRows.indexOf(indexPath.section){
                return 50
            }else{
                return 640
            }
        default:
            return 44
        }
    }
    
    
    //MARK: Cell Delegate
    func collapseThisCell(rowNum: Int, isCollapsing:Bool) {
        if isCollapsing{
            if self.collapsedRows.indexOf(rowNum) == nil{
                self.collapsedRows.append(rowNum)
            }
        }else{
            if let temp = self.collapsedRows.indexOf(rowNum){
                self.collapsedRows.removeAtIndex(temp)
            }
        }
        self.tableView.reloadData()
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homeviewcontrollerIdentifier")
//        self.presentViewController(vc, animated: true, completion: nil)

    }
    
}
