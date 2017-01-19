//
//  PickerViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/19/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

enum PickerViewType:Int{
    case patient
    case caseType
    case physician
    case compoundProfile
    case pathologist
    case insuranceType
}

protocol PickerViewCallBackDelegate{
    func updateFormWithPickerSelection(_ value:String, forType:PickerViewType)
}

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerViewTitle: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData:NSMutableArray = []
    var pickerViewType:PickerViewType = .patient
    var currentField:UITextField?
    var delegate:PickerViewCallBackDelegate?
    var patientsData:[Patient]?
    var pathologistData:[Pathologist]?
    var physicianData: [Physician]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let tabBarVC = appDelegate.window?.rootViewController as? HomeTabBarViewController else {return}
        
        switch pickerViewType{
        case .patient:
            self.pickerViewTitle.text = "Select Patient"
            self.patientsData = tabBarVC.patientList
            break
        case .caseType:
            self.pickerViewTitle.text = "Select Case Type"
            break
        case .physician:
            self.pickerViewTitle.text = "Select Physician"
            self.physicianData = tabBarVC.physiciansList
            break
        case .compoundProfile:
            self.pickerViewTitle.text = "Select Profile"
            break
        case .pathologist:
            self.pickerViewTitle.text = "Select Pathlogist"
            self.pathologistData = tabBarVC.pathologistsList
            break
        default:
            self.pickerViewTitle.text = "Select Insurance Type"

            break
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PickerViewController.dismissPickerView(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func closePickerView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissPickerView(_ sender:UIGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerViewType{
        case .patient:
            if let data = self.patientsData{
                return data[row].firstName as String?
            }
            break
        case .physician:
            if let data = self.physicianData{
                return data[row].firstName as String?
            }
            break
        case .pathologist:
            if let data = self.pathologistData{
                return data[row].firstName as String?
            }
            break
        default:
            self.pickerViewTitle.text = "Select Insurance Type"
            break
        }
        return pickerData[row] as? String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerViewType{
        case .patient:
            if let data = self.patientsData{
                return data.count
            }
            break
        case .physician:
            if let data = self.physicianData{
                return data.count
            }
            break
        case .pathologist:
            if let data = self.pathologistData{
                return data.count
            }
            break
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var utext = ""
        switch pickerViewType{
        case .patient:
            if let data = self.patientsData{
                utext = (data[row].firstName as? String)!
                self.delegate?.updateFormWithPickerSelection("\(data[row].patientId!)", forType: self.pickerViewType)
            }
            break
        case .physician:
            if let data = self.physicianData{
                utext = (data[row].firstName as? String)!
                self.delegate?.updateFormWithPickerSelection("\(data[row].phyId!)", forType: self.pickerViewType)
            }
            break
        case .pathologist:
            if let data = self.pathologistData{
                utext = (data[row].firstName as? String)!
                self.delegate?.updateFormWithPickerSelection("\(data[row].pathId!)", forType: self.pickerViewType)
            }
            break
        default:
            break
        }
        self.currentField?.text = utext
    }
    
    func assortDataForPatient(){
        
    }
    
    
    
    func getPatients(){
        let patients = coredatahandler.fetchPatientDetails() as [PatientDetails]
        for patient in patients{
            self.pickerData.add("\(patient.firstName!) \(patient.lastName!)")
        }
    }
}
