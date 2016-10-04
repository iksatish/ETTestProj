//
//  PhysicistTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/14/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class PhysicistTableViewCell: UITableViewCell {
    var delegate:DetailsCellDelegate?
    var rowNum = 0
    var isCollapsed = false
    @IBOutlet weak var detalisView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func collapseCell(_ sender: UIButton) {
        self.isCollapsed = !self.isCollapsed
        self.delegate?.collapseThisCell(self.rowNum, isCollapsing: isCollapsed)
    }
}
