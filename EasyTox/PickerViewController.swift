//
//  PickerViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/19/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

enum PickerViewType:Int{
    case Patient
    case CaseType
    case Physician
    case CompoundProfile
    case Pathologist
    case InsuranceType
}

protocol PickerViewCallBackDelegate{
    func updateFormWithPickerSelection(value:String, forType:PickerViewType)
}

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerViewTitle: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData = []
    var pickerViewType:PickerViewType = .Patient
    var currentField:UITextField?
    var delegate:PickerViewCallBackDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        switch pickerViewType{
        case .Patient:
            self.pickerData = ["Patient 1", "Patient 2"]
            self.pickerViewTitle.text = "Select Patient"
            break
        case .CaseType:
            self.pickerData = ["Urine", "Oral"]
            self.pickerViewTitle.text = "Select Case Type"
            break
        case .Physician:
            self.pickerData = ["Physician 1", "Physician 2", "Physician 3", "Physician 4", "Physician 5"]
            self.pickerViewTitle.text = "Select Physician"
            break
        case .CompoundProfile:
            self.pickerData = ["Profile 1", "Profile 2"]
            self.pickerViewTitle.text = "Select Profile"
            break
        case .Pathologist:
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissPickerView:"))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func closePickerView(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissPickerView(sender:UIGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as? String
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentField?.text = self.pickerData[row] as? String
//        self.delegate?.updateFormWithPickerSelection(self.pickerData[row] as! String, forType: self.pickerViewType)
    }
}
