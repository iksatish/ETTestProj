//
//  LegacyInputTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class LegacyInputTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.errorLabel.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFieldForPatientInput(indexPath:NSIndexPath, forCell:Int){
        if forCell == 0{
            switch indexPath.row{
            case 2:
                self.headerLabel.text = "SSN"
                self.inputField.placeholder = "SSN"
            case 6:
                self.headerLabel.text = "Employment"
                self.inputField.placeholder = "Employment Status"
            case 7:
                self.headerLabel.text = "Medical Record"
                self.inputField.placeholder = "SSN"
            case 8:
                self.headerLabel.text = "Alternative ID"
                self.inputField.placeholder = "Alternative ID"
            default:
                self.headerLabel.text = ""
            }
        }else{
            switch indexPath.row{
            case 1:
                self.headerLabel.text = "Relaton"
                self.inputField.text = "Select One"
                self.inputField.setUpField(.DROPDOWN)
            case 3:
                self.headerLabel.text = "SSN"
                self.inputField.placeholder = "SSN"
            case 4:
                self.headerLabel.text = "Marital Status"
                self.inputField.placeholder = "Select One"
                self.inputField.setUpField(.DROPDOWN)
            default:
                self.headerLabel.text = ""
            }

        }
    }

}
