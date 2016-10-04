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
    override func viewDidLoad() {
        super.viewDidLoad()
        switch pickerViewType{
        case .patient:
            self.getPatients()
            self.pickerViewTitle.text = "Select Patient"
            break
        case .caseType:
            self.pickerData = ["Urine", "Oral"]
            self.pickerViewTitle.text = "Select Case Type"
            break
        case .physician:
            self.pickerData = ["Physician 1", "Physician 2", "Physician 3", "Physician 4", "Physician 5"]
            self.pickerViewTitle.text = "Select Physician"
            break
        case .compoundProfile:
            self.pickerData = ["Profile 1", "Profile 2"]
            self.pickerViewTitle.text = "Select Profile"
            break
        case .pathologist:
            self.pickerData = ["Pathologist 1", "Pathologist 2"]
            self.pickerViewTitle.text = "Select Pathlogist"
            break
        default:
            self.pickerData = ["Primary", "Secondary", "Teritary", "Worksmen", "None"]
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
        return pickerData[row] as? String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentField?.text = self.pickerData[row] as? String
//        self.delegate?.updateFormWithPickerSelection(self.pickerData[row] as! String, forType: self.pickerViewType)
    }
    
    func getPatients(){
        let patients = coredatahandler.fetchPatientDetails() as [PatientDetails]
        for patient in patients{
            self.pickerData.add("\(patient.firstName!) \(patient.lastName!)")
        }
    }
}
