//
//  ButtonsTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

protocol ButtonsCellDelegate{
    func updateTableViewWithInsuranceInfo(_ tag:Int)
}
class ButtonsTableViewCell: UITableViewCell {
    var delegate:ButtonsCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBAction func onTappingButton(_ sender: UIButton) {
        self.delegate?.updateTableViewWithInsuranceInfo(sender.tag)
        if sender.tag == 1{
            
        }else{
            
        }
    }
    
    func updateButtonsTitle(_ titleTag:Int, isworksmanCellAdded:Bool){
        var titleTag = titleTag
        if isworksmanCellAdded {
            titleTag += 1
        }
        var title = "Add Primary"
            switch titleTag{
            case 1:
                title = "Add Secondary"
            case 2:
                title = "Add Teritary"
            default:
                title = "Add Primary"
            }
        self.secondButton.setTitle(title, for: UIControlState())
    }
}
