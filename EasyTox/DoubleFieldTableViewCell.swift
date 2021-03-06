//
//  DoubleFieldTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/19/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit
protocol PickerFieldViewDelegate{
    func openPickerViewForField(_ textField:UITextField, forPickerType:PickerViewType)
}

class DoubleFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var firstFieldView: UIView!
    @IBOutlet weak var secondFieldView: UIView!
    @IBOutlet weak var firstHeaderLabel: UILabel!
    @IBOutlet weak var firstInputField: UITextField!
    @IBOutlet weak var firstErrorLabel: UILabel!
    @IBOutlet weak var secondHeaderLabel: UILabel!
    @IBOutlet weak var secondErrorLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var radioFieldView: UIView!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var firstViewButton: UIButton!
    @IBOutlet weak var secondViewButton: UIButton!
    var delegate:PickerFieldViewDelegate?
    var firstPickerViewType:PickerViewType = PickerViewType.patient
    var secondPickerViewType:PickerViewType = PickerViewType.patient
    var caseForm = CaseForm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstViewButton.isHidden = true
        self.secondViewButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(_ indexPath:IndexPath, cellFor:String){
        if cellFor == patientFormIdentifier{
            switch (indexPath as NSIndexPath).row{
            case 2:
                self.firstHeaderLabel.text = "Case Accession"
                self.firstInputField.setUpField(FieldType.label)
                self.secondHeaderLabel.text = "Medical Record #"
            case 3:
                self.firstHeaderLabel.text = "Date Collected"
                self.secondHeaderLabel.text = "Date Received"
                self.firstInputField.placeholder = "  MM/dd/yyyy"
                self.secondTextField.placeholder = "  MM/dd/yyyy"
            case 4:
                self.firstHeaderLabel.text = "Case Type"
                self.firstInputField.placeholder = "  Select Case Type"
                self.firstInputField.setUpField(FieldType.dropdown)
                self.firstViewButton.isHidden = false
                self.firstPickerViewType = .caseType
                self.secondHeaderLabel.text = "Logged In By"
                self.secondTextField.isEnabled = false
            case 5:
                self.firstHeaderLabel.text = "Prescribed Medicine"
                self.secondFieldView.isHidden = true
            default:
                self.firstHeaderLabel.text = ""
                self.secondFieldView.isHidden = true
            }
            
        }else if cellFor == physicianFormIdentifier{
            self.radioFieldView.isHidden = true

            switch (indexPath as NSIndexPath).row{
            case 1:
                self.firstHeaderLabel.text = "Primary Physician"
                self.firstInputField.setUpField(FieldType.dropdown)
                self.firstViewButton.isHidden = false
                self.firstPickerViewType = .primaryPhysician
                self.firstInputField.placeholder = "  Select Physician"
                self.secondHeaderLabel.text = "Secondary Physician"
                self.secondTextField.setUpField(FieldType.dropdown)
                self.secondViewButton.isHidden = false
                self.secondTextField.placeholder = "  Select Physician"
                self.secondPickerViewType = .secondaryPhysician
            case 2:
                self.firstHeaderLabel.text = "Cc Physician"
                self.firstViewButton.isHidden = false
                self.firstPickerViewType = .ccPhysician
                self.firstInputField.placeholder = "  Select Cc Physician"
                self.secondHeaderLabel.text = "Compound Profile"
                self.secondViewButton.isHidden = true
                self.secondTextField.placeholder = "  Select Profile"
            case 3:
                self.firstHeaderLabel.text = "Pathologist"
                self.firstInputField.setUpField(FieldType.dropdown)
                self.firstInputField.placeholder = "  Select Pathologist"
                self.firstPickerViewType = .pathologist
                self.firstViewButton.isHidden = false
                self.secondFieldView.isHidden = true
            case 4:
                self.firstHeaderLabel.text = "Final Interpretation"
                self.secondFieldView.isHidden = true
                self.radioFieldView.isHidden = false
            case 5:
                self.firstHeaderLabel.text = "Insurance Type"
                self.firstInputField.setUpField(FieldType.dropdown)
                self.firstPickerViewType = .insuranceType
                self.firstViewButton.isHidden = false
                self.firstInputField.placeholder = "  Select Insurance Type"
                self.secondFieldView.isHidden = true
            case 6:
                self.firstHeaderLabel.text = "Injury Date"
                self.firstInputField.text = "  mm/dd/yyyy"
                self.secondHeaderLabel.text = "Claim Number"
            default:
                self.firstHeaderLabel.text = ""
                self.secondFieldView.isHidden = true
            }
            
        }
        
    }
    @IBAction func openPickerView(_ sender: UIButton) {
        if sender.tag == 1{
            self.delegate?.openPickerViewForField(self.firstInputField, forPickerType: self.firstPickerViewType)
        }else{
            self.delegate?.openPickerViewForField(self.secondTextField, forPickerType: self.secondPickerViewType)
        }
    }
    
}
