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
        self.tableView.register(UINib(nibName: "SingleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: singleCellIdentifier)
        self.tableView.register(UINib(nibName: "DoubleFieldTableViewCell", bundle: nil), forCellReuseIdentifier: doubleCellIdentifier)
        self.tableView.register(UINib(nibName: "PatientInfoTableViewCell", bundle: nil), forCellReuseIdentifier: patientInfoCellIdentifier)
        self.tableView.register(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
        self.tableView.register(UINib(nibName: "TripleCellTableViewCell", bundle: nil), forCellReuseIdentifier: tripleCellIdentifier)
        self.tableView.register(UINib(nibName: "DobAgeTableViewCell", bundle: nil), forCellReuseIdentifier: dobAgeCellIdentifier)
        self.tableView.register(UINib(nibName: "LegacyInputTableViewCell", bundle: nil), forCellReuseIdentifier: legacyCellIdentifier)
        self.tableView.register(UINib(nibName: "InsuranceTableViewCell", bundle: nil), forCellReuseIdentifier:insuranceCellIdentifier)
        self.tableView.register(UINib(nibName: "ButtonsTableViewCell", bundle: nil), forCellReuseIdentifier:insButtonsCellIdentifier)
        

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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0{
            return 10
        }else if segmentedControl.selectedSegmentIndex == 1{
            return 7
        }else{
            return numOfInsCells+1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 2 && (indexPath as NSIndexPath).row != 0{
            return 300
        }else{
            return 65
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0{
            switch (indexPath as NSIndexPath).row{
            case 0,3,4,5,9:
                let cell:TripleCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: tripleCellIdentifier)! as! TripleCellTableViewCell
                cell.setupFieldForPatientInput(indexPath, forCell: segmentedControl.selectedSegmentIndex)
                return cell
            case 1:
                let cell:DobAgeTableViewCell = tableView.dequeueReusableCell(withIdentifier: dobAgeCellIdentifier)! as! DobAgeTableViewCell
                return cell
            default:
                let cell:LegacyInputTableViewCell = tableView.dequeueReusableCell(withIdentifier: legacyCellIdentifier)! as! LegacyInputTableViewCell
                cell.setupFieldForPatientInput(indexPath, forCell: segmentedControl.selectedSegmentIndex)
                return cell
            }
        }else if segmentedControl.selectedSegmentIndex == 1{
            switch (indexPath as NSIndexPath).row{
            case 0,5,6,7:
                let cell:TripleCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: tripleCellIdentifier)! as! TripleCellTableViewCell
                cell.setupFieldForPatientInput(indexPath, forCell: segmentedControl.selectedSegmentIndex)
                return cell
            case 1:
                let cell:DobAgeTableViewCell = tableView.dequeueReusableCell(withIdentifier: dobAgeCellIdentifier)! as! DobAgeTableViewCell
                return cell
            default:
                let cell:LegacyInputTableViewCell = tableView.dequeueReusableCell(withIdentifier: legacyCellIdentifier)! as! LegacyInputTableViewCell
                return cell
            }
        }else{
            if (indexPath as NSIndexPath).row == 0{
                let cell:ButtonsTableViewCell = tableView.dequeueReusableCell(withIdentifier: insButtonsCellIdentifier)! as! ButtonsTableViewCell
                cell.delegate = self
                let cellTag = numOfInsCells - (isWorksMenCellAdded ? 1 : 0)
                cell.updateButtonsTitle(cellTag, isworksmanCellAdded: isWorksMenCellAdded)
                return cell
            }else{
                let cell:InsuranceTableViewCell = tableView.dequeueReusableCell(withIdentifier: insuranceCellIdentifier)! as! InsuranceTableViewCell
                return cell
            }
        }

    }

    @IBAction func onChangingSegment(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    func openPickerViewForField(_ textField: UITextField, forPickerType: PickerViewType) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }

    func updateTableViewWithInsuranceInfo(_ tag: Int) {
        if tag == 0{
            isWorksMenCellAdded = true
        }else{
            
        }
        numOfInsCells += 1
        self.tableView.reloadData()
    }
    @IBAction func cancelAdding(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doAddPatient(_ sender: UIButton) {
        let pf = PatientForm()
        pf.lastName = "last"
        pf.firstName = "first"
        let cd = CoreDatahandler()
        cd.saveNewPatient(pf)
        
    }
}
