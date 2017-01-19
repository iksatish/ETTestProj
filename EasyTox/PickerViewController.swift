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
    case primaryPhysician
    case secondaryPhysician
    case ccPhysician
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
        case .primaryPhysician, .secondaryPhysician, .ccPhysician:
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
        case .insuranceType:
            self.pickerData = ["Primary", "Secondary", "Tertiary", "Worksmen", "None"]
            self.pickerViewTitle.text = "Select Insurance Type"
            break
        case .caseType:
            self.pickerData = ["Oral", "Urine"]
            self.pickerViewTitle.text = "Select Case Type"
            break
        default:
            break
        }
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerViewType{
        case .patient:
            return self.getPatientName(index: row)
        case .primaryPhysician, .secondaryPhysician, .ccPhysician:
            return self.getPhyName(index: row)
        case .pathologist:
            return self.getPatholoName(index: row)
        case .insuranceType, .caseType:
            return pickerData[row] as? String
        default:
            break
        }
        return ""
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
        case .primaryPhysician, .secondaryPhysician, .ccPhysician:
            if let data = self.physicianData{
                return data.count
            }
            break
        case .pathologist:
            if let data = self.pathologistData{
                return data.count
            }
            break
        case .insuranceType, .caseType:
            return self.pickerData.count
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
                utext = self.getPatientName(index: row)
                self.delegate?.updateFormWithPickerSelection("\(data[row].patientId!)", forType: self.pickerViewType)
            }
            break
        case .primaryPhysician, .secondaryPhysician, .ccPhysician:
            if let data = self.physicianData{
                utext = self.getPhyName(index: row)
                self.delegate?.updateFormWithPickerSelection("\(data[row].phyId!)", forType: self.pickerViewType)
            }
            break
        case .pathologist:
            if let data = self.pathologistData{
                utext = self.getPatholoName(index: row)
                self.delegate?.updateFormWithPickerSelection("\(data[row].pathId!)", forType: self.pickerViewType)
            }
            break
        case .insuranceType, .caseType:
            utext = self.pickerData[row] as! String
            self.delegate?.updateFormWithPickerSelection(utext, forType: self.pickerViewType)
            break
        default:
            break
        }
        self.currentField?.text = utext
    }
    
    func assortDataForPatient(){
        
    }
    
    
    
    func getPatientName(index:Int) -> String{
        guard let patients = self.patientsData else {return ""}
        var cusName = ""
        let pat = patients[index]
        if let fn = pat.firstName as? String{
            cusName = fn.capitalized
        }
        if let ln = pat.lastName as? String{
            cusName = cusName + " " + ln.capitalized
        }
        if let medRecNo = pat.medRecNo as? String{
            cusName = cusName + " Record Number:" + medRecNo
        }
        if let dob = pat.dateOfBirth as? String{
            cusName = cusName + " DOB:" + dob
        }
        return cusName
    }
    
    func getPatholoName(index:Int) -> String{
        guard let paths = self.pathologistData else {return ""}
        var cusName = ""
        let pat = paths[index]
        if let fn = pat.firstName as? String{
            cusName = fn.capitalized
        }
        if let ln = pat.lastName as? String{
            cusName = cusName + " " + ln.capitalized
        }
        return cusName
    }
    
    func getPhyName(index:Int) -> String{
        guard let phys = self.physicianData else {return ""}
        var cusName = ""
        let pat = phys[index]
        if let fn = pat.firstName as? String{
            cusName = fn.capitalized
        }
        if let ln = pat.lastName as? String{
            cusName = cusName + " " + ln.capitalized
        }
        return cusName
    }
    
}
