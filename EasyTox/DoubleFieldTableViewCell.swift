//
//  DoubleFieldTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/19/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit
protocol PickerFieldViewDelegate{
    func openPickerViewForField(textField:UITextField, forPickerType:PickerViewType)
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
    var firstPickerViewType:PickerViewType = PickerViewType.Patient
    var secondPickerViewType:PickerViewType = PickerViewType.Patient
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstViewButton.hidden = true
        self.secondViewButton.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(indexPath:NSIndexPath, cellFor:String){
        if cellFor == patientFormIdentifier{
            switch indexPath.row{
            case 2:
                self.firstHeaderLabel.text = "Case Accession"
                self.firstInputField.setUpField(FieldType.LABEL)
                self.secondHeaderLabel.text = "Medical Record #"
            case 3:
                self.firstHeaderLabel.text = "Date Collected"
                self.secondHeaderLabel.text = "Date Received"
            case 4:
                self.firstHeaderLabel.text = "Case Type"
                self.firstInputField.text = "  Select One"
                self.firstInputField.setUpField(FieldType.DROPDOWN)
                self.firstViewButton.hidden = false
                self.firstPickerViewType = .CaseType
                self.secondHeaderLabel.text = "Logged In By"
                self.secondTextField.setUpField(FieldType.LABEL)
            case 5:
                self.firstHeaderLabel.text = "Prescribed Medicine"
                self.secondFieldView.hidden = true
            default:
                self.firstHeaderLabel.text = ""
                self.secondFieldView.hidden = true
            }
            
        }else if cellFor == physicianFormIdentifier{
            switch indexPath.row{
            case 1:
                self.firstHeaderLabel.text = "Primary Physician"
                self.firstInputField.setUpField(FieldType.DROPDOWN)
                self.firstViewButton.hidden = false
                self.firstPickerViewType = .Physician
                self.firstInputField.text = "  Select Physician"
                self.secondHeaderLabel.text = "Secondary Physician"
                self.secondTextField.setUpField(FieldType.DROPDOWN)
                self.secondViewButton.hidden = false
                self.secondTextField.text = "  Select Physician"
                self.secondPickerViewType = .Physician
            case 2:
                self.firstHeaderLabel.text = "Cc Physician"
                self.firstInputField.setUpField(FieldType.DROPDOWN)
                self.firstViewButton.hidden = false
                self.firstPickerViewType = .Physician
                self.secondHeaderLabel.text = "Compound Profile"
                self.secondTextField.setUpField(FieldType.DROPDOWN)
                self.secondViewButton.hidden = false
                self.secondTextField.text = "  Select Profile"
                self.secondPickerViewType = .Physician
            case 3:
                self.firstHeaderLabel.text = "Pathologist"
                self.firstInputField.setUpField(FieldType.DROPDOWN)
                self.firstInputField.text = "  Select Pathologist"
                self.firstPickerViewType = .Pathologist
                self.firstViewButton.hidden = false
                self.firstInputField.text = "  Select Physician"
                self.secondFieldView.hidden = true
            case 4:
                self.firstHeaderLabel.text = "Final Interpretation"
                self.secondFieldView.hidden = true
                self.radioFieldView.hidden = false
            case 5:
                self.firstHeaderLabel.text = "Insurance Type"
                self.firstInputField.setUpField(FieldType.DROPDOWN)
                self.firstPickerViewType = .InsuranceType
                self.firstViewButton.hidden = false
                self.firstInputField.text = "  Select Insurance Type"
                self.secondFieldView.hidden = true
            case 6:
                self.firstHeaderLabel.text = "Injury Date"
                self.firstInputField.text = "  mm/dd/yyyy"
                self.secondHeaderLabel.text = "Claim Number"
            default:
                self.firstHeaderLabel.text = ""
                self.secondFieldView.hidden = true
            }
            
        }
        
    }
    @IBAction func openPickerView(sender: UIButton) {
        if sender.tag == 1{
            self.delegate?.openPickerViewForField(self.firstInputField, forPickerType: self.firstPickerViewType)
        }else{
            self.delegate?.openPickerViewForField(self.secondTextField, forPickerType: self.secondPickerViewType)
        }
    }
    
}
