//
//  AddNewCaseViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/14/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class AddNewCaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailsCellDelegate, PickerFieldViewDelegate, PickerViewCallBackDelegate,SingleFieldCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var collapsedRows:[Int] = []
    var caseForm:CaseForm = CaseForm()
    var insuranceType:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "SingleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: singleCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "DoubleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: doubleCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "PatientInfoTableViewCell", bundle: nil), forCellReuseIdentifier: patientInfoCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
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
        switch section{
        case 1:
            return 6
        case 2:
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell:PatientInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier(patientInfoCellIdentifier)! as! PatientInfoTableViewCell
            return cell
        case 1:
            if indexPath.row == 0{
                let cell:HeaderCellTableViewCell = tableView.dequeueReusableCellWithIdentifier(headerCellIdentifier)! as! HeaderCellTableViewCell
                
                return cell
            }else if indexPath.row == 1{
                let cell:SingleFieldTableViewCell = tableView.dequeueReusableCellWithIdentifier(singleCellIdentifier)! as! SingleFieldTableViewCell
                cell.addButton.hidden = false
                cell.headerLabel.text = "Patient"
                cell.inputField.text = "Select Patient"
                cell.inputField.setUpField(FieldType.DROPDOWN)
                cell.delegate = self
                return cell
            }else{
                let cell:DoubleFieldTableViewCell = tableView.dequeueReusableCellWithIdentifier(doubleCellIdentifier)! as! DoubleFieldTableViewCell
                cell.setUpCell(indexPath, cellFor: patientFormIdentifier)
                cell.delegate = self
                return cell
            }
        case 2:
            if indexPath.row == 0{
                let cell:HeaderCellTableViewCell = tableView.dequeueReusableCellWithIdentifier(headerCellIdentifier)! as! HeaderCellTableViewCell
                return cell
            }else{
                let cell:DoubleFieldTableViewCell = tableView.dequeueReusableCellWithIdentifier(doubleCellIdentifier)! as! DoubleFieldTableViewCell
                cell.setUpCell(indexPath, cellFor: physicianFormIdentifier)
                cell.delegate = self
                return cell
            }
        default:
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("submitCellIdentifier")! as UITableViewCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 150
        case 3:
            return 44
        default:
            if indexPath.row == 0{
                return 45
            }else{
                return 85
            }
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

    }
    
    func openPickerViewForField(textField: UITextField, forPickerType: PickerViewType) {
        let vc:PickerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("pickerViewControllerIdentifier") as! PickerViewController
        vc.pickerViewType = forPickerType
        vc.currentField = textField
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func updateFormWithPickerSelection(value: String, forType: PickerViewType) {
        if forType == .InsuranceType{
            self.insuranceType = value
            self.tableView.reloadData()
        }
    }
    
    func openNewPatientView() {
        let vc:NewPatientViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("newPatientViewControllerIdentifier") as! NewPatientViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
