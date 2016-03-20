//
//  NewPatientViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class NewPatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PickerFieldViewDelegate, ButtonsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var isWorksMenCellAdded:Bool = false
    var numOfInsCells = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "SingleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: singleCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "DoubleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: doubleCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "PatientInfoTableViewCell", bundle: nil), forCellReuseIdentifier: patientInfoCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "TripleCellTableViewCell", bundle: nil), forCellReuseIdentifier: tripleCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "DobAgeTableViewCell", bundle: nil), forCellReuseIdentifier: dobAgeCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "LegacyInputTableViewCell", bundle: nil), forCellReuseIdentifier: legacyCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "InsuranceTableViewCell", bundle: nil), forCellReuseIdentifier:insuranceCellIdentifier)
        self.tableView.registerNib(UINib(nibName: "ButtonsTableViewCell", bundle: nil), forCellReuseIdentifier:insButtonsCellIdentifier)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0{
            return 10
        }else if segmentedControl.selectedSegmentIndex == 1{
            return 7
        }else{
            return numOfInsCells+1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 2 && indexPath.row != 0{
            return 300
        }else{
            return 65
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0{
            switch indexPath.row{
            case 0,3,4,5,9:
                let cell:TripleCellTableViewCell = tableView.dequeueReusableCellWithIdentifier(tripleCellIdentifier)! as! TripleCellTableViewCell
                cell.setupFieldForPatientInput(indexPath, forCell: segmentedControl.selectedSegmentIndex)
                return cell
            case 1:
                let cell:DobAgeTableViewCell = tableView.dequeueReusableCellWithIdentifier(dobAgeCellIdentifier)! as! DobAgeTableViewCell
                return cell
            default:
                let cell:LegacyInputTableViewCell = tableView.dequeueReusableCellWithIdentifier(legacyCellIdentifier)! as! LegacyInputTableViewCell
                cell.setupFieldForPatientInput(indexPath, forCell: segmentedControl.selectedSegmentIndex)
                return cell
            }
        }else if segmentedControl.selectedSegmentIndex == 1{
            switch indexPath.row{
            case 0,5,6,7:
                let cell:TripleCellTableViewCell = tableView.dequeueReusableCellWithIdentifier(tripleCellIdentifier)! as! TripleCellTableViewCell
                cell.setupFieldForPatientInput(indexPath, forCell: segmentedControl.selectedSegmentIndex)
                return cell
            case 1:
                let cell:DobAgeTableViewCell = tableView.dequeueReusableCellWithIdentifier(dobAgeCellIdentifier)! as! DobAgeTableViewCell
                return cell
            default:
                let cell:LegacyInputTableViewCell = tableView.dequeueReusableCellWithIdentifier(legacyCellIdentifier)! as! LegacyInputTableViewCell
                return cell
            }
        }else{
            if indexPath.row == 0{
                let cell:ButtonsTableViewCell = tableView.dequeueReusableCellWithIdentifier(insButtonsCellIdentifier)! as! ButtonsTableViewCell
                cell.delegate = self
                let cellTag = numOfInsCells - (isWorksMenCellAdded ? 1 : 0)
                cell.updateButtonsTitle(cellTag, isworksmanCellAdded: isWorksMenCellAdded)
                return cell
            }else{
                let cell:InsuranceTableViewCell = tableView.dequeueReusableCellWithIdentifier(insuranceCellIdentifier)! as! InsuranceTableViewCell
                return cell
            }
        }

    }

    @IBAction func onChangingSegment(sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    func openPickerViewForField(textField: UITextField, forPickerType: PickerViewType) {
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }

    func updateTableViewWithInsuranceInfo(tag: Int) {
        if tag == 0{
            isWorksMenCellAdded = true
        }else{
            
        }
        numOfInsCells++
        self.tableView.reloadData()
    }
    @IBAction func cancelAdding(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func doAddPatient(sender: UIButton) {
        let pf = PatientForm()
        pf.lastName = "last"
        pf.firstName = "first"
        let cd = CoreDatahandler()
        cd.saveNewPatient(pf)
        
    }
}
