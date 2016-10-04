//
//  TripleCellTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class TripleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thridView: UIView!
    @IBOutlet weak var firstInputField: UITextField!
    @IBOutlet weak var firstErrorLabel: UILabel!
    @IBOutlet weak var secondInputField: UITextField!
    @IBOutlet weak var secondErrorLabel: UILabel!
    @IBOutlet weak var thirdInputField: UITextField!
    @IBOutlet weak var thirdErrorLabel: UILabel!
    @IBOutlet weak var labelHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstErrorLabel.text = ""
        self.secondErrorLabel.text = ""
        self.thirdErrorLabel.text = ""
        self.firstView.isHidden = false
        self.secondView.isHidden = false
        self.thridView.isHidden = false
        self.labelHeightConstraint.constant = 21
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFieldForPatientInput(_ indexPath:IndexPath, forCell:Int){
        if forCell == 0{
            switch (indexPath as NSIndexPath).row{
            case 0:
                self.headerLabel.text = "Name"
                self.firstInputField.placeholder = "First Name"
                self.secondInputField.placeholder = "Middle Name"
                self.thirdInputField.placeholder = "Last Name"
            case 3:
                self.headerLabel.text = "Address"
                self.firstInputField.placeholder = "Address 1"
                self.secondInputField.placeholder = "Address 2"
                self.thirdInputField.placeholder = "City"
            case 4:
                self.headerLabel.text = ""
                self.firstInputField.placeholder = "State"
                self.secondInputField.placeholder = "Zip Code"
                self.thridView.isHidden = true
            case 5:
                self.headerLabel.text = "Contact"
                self.firstInputField.placeholder = "Home Phone"
                self.secondInputField.placeholder = "Mobile Phone"
                self.thirdInputField.placeholder = "Email"
            case 9:
                self.headerLabel.text = "Emergency Contact"
                self.labelHeightConstraint.constant = 30
                self.headerLabel.numberOfLines = 0
                self.updateConstraints()
                self.firstInputField.placeholder = "Contact Name"
                self.secondInputField.placeholder = "Phone Number"
                self.thirdInputField.placeholder = "Relation"
            default:
                self.headerLabel.text = ""
            }
        }else{
            switch (indexPath as NSIndexPath).row{
            case 0:
                self.headerLabel.text = "Name"
                self.firstInputField.placeholder = "First Name"
                self.secondInputField.placeholder = "Middle Name"
                self.thirdInputField.placeholder = "Last Name"
            case 5:
                self.headerLabel.text = "Address"
                self.firstInputField.placeholder = "Address 1"
                self.secondInputField.placeholder = "Address 2"
                self.thirdInputField.placeholder = "City"
            case 6:
                self.headerLabel.text = ""
                self.firstInputField.placeholder = "State"
                self.secondInputField.placeholder = "Zip Code"
                self.thridView.isHidden = true
            case 7:
                self.headerLabel.text = "Contact"
                self.firstInputField.placeholder = "Home Phone"
                self.secondInputField.placeholder = "Mobile Phone"
                self.thirdInputField.placeholder = "Email"
            default:
                self.headerLabel.text = ""
            }

        }
    }
}
