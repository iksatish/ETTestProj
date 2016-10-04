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
        self.tableView.register(UINib(nibName: "SingleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: singleCellIdentifier)
        self.tableView.register(UINib(nibName: "DoubleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: doubleCellIdentifier)
        self.tableView.register(UINib(nibName: "PatientInfoTableViewCell", bundle: nil), forCellReuseIdentifier: patientInfoCellIdentifier)
        self.tableView.register(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).section{
        case 0:
            let cell:PatientInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: patientInfoCellIdentifier)! as! PatientInfoTableViewCell
            return cell
        case 1:
            if (indexPath as NSIndexPath).row == 0{
                let cell:HeaderCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier)! as! HeaderCellTableViewCell
                
                return cell
            }else if (indexPath as NSIndexPath).row == 1{
                let cell:SingleFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: singleCellIdentifier)! as! SingleFieldTableViewCell
                cell.addButton.isHidden = false
                cell.headerLabel.text = "Patient"
                cell.inputField.text = "Select Patient"
                cell.inputField.setUpField(FieldType.dropdown)
                cell.delegate = self
                cell.pickerDelegate = self
                return cell
            }else{
                let cell:DoubleFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: doubleCellIdentifier)! as! DoubleFieldTableViewCell
                cell.setUpCell(indexPath, cellFor: patientFormIdentifier)
                cell.delegate = self
                return cell
            }
        case 2:
            if (indexPath as NSIndexPath).row == 0{
                let cell:HeaderCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier)! as! HeaderCellTableViewCell
                return cell
            }else{
                let cell:DoubleFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: doubleCellIdentifier)! as! DoubleFieldTableViewCell
                cell.setUpCell(indexPath, cellFor: physicianFormIdentifier)
                cell.delegate = self
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
        case 0:
            return 150
        case 3:
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
        if forType == .insuranceType{
            self.insuranceType = value
            self.tableView.reloadData()
        }
    }
    
    func openNewPatientView() {
        let vc:NewPatientViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newPatientViewControllerIdentifier") as! NewPatientViewController
        self.present(vc, animated: true, completion: nil)
    }

}
