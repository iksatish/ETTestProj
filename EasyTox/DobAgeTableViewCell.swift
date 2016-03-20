//
//  DobAgeTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class DobAgeTableViewCell: UITableViewCell {

    @IBOutlet weak var firstInputField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstErrorLabel.text = ""
        self.secondErrorLabel.text = ""
        
    }

    @IBOutlet weak var firstErrorLabel: UILabel!
    @IBOutlet weak var secondErrorLabel: UILabel!
    @IBOutlet weak var secondInputField: UITextField!
    @IBOutlet weak var ageInputFIeld: UITextField!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.firstInputField.setUpField(.DROPDOWN)
        self.secondInputField.setUpField(.LABEL)
        // Configure the view for the selected state
    }
    
}
