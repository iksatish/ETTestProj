//
//  SingleFieldTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/19/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

@objc
protocol SingleFieldCellDelegate{
    @objc optional func openNewPatientView()
}
class SingleFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var delegate:SingleFieldCellDelegate?
    var pickerDelegate:PickerFieldViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTappingAdd(_ sender: UIButton) {
        self.delegate?.openNewPatientView!()
    }
    @IBAction func selectPatient(_ sender: UIButton) {
        self.pickerDelegate?.openPickerViewForField(self.inputField, forPickerType: PickerViewType.patient)
    }
}
