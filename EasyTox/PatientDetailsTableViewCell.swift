//
//  PatientDetailsTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/14/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

protocol DetailsCellDelegate{
    func collapseThisCell(_ rowNum:Int, isCollapsing:Bool)
}
class PatientDetailsTableViewCell: UITableViewCell, UITextFieldDelegate {
    var delegate:DetailsCellDelegate?
    var rowNum = 0
    @IBOutlet weak var patientView: CustomTextFieldView!
    @IBOutlet weak var detailsView: UIView!
    var isCollapsed = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.patientView.curTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func collapseCell(_ sender: UIButton) {
        self.isCollapsed = !self.isCollapsed
        self.delegate?.collapseThisCell(self.rowNum, isCollapsing: isCollapsed)
    }
    
    //MARK: Textfield delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}
