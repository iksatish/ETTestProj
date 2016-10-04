//
//  ListTableViewCell.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var textFields: [UILabel]!
    var actualFormData:CaseForm?
    var caseForm:CaseFormSimplified?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for view in self.columnViews{
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.gray.cgColor
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var columnViews: [UIView]!

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    func setUpHeader(){
    }
    
    func setUpImages(){
    }
    
    //SetUp
    func setupData(_ row:Int){
        if row == 0{
            textFields[0].text = "Case Accession #"
            textFields[1].text = "First Name"
            textFields[2].text = "Last Name"
            textFields[3].text = "Date of Birth"
            textFields[4].text = "Date Collected"
            textFields[5].text = "Medical Record #"
            textFields[6].text = "Status"
            textFields[7].text = "Action"
            textFields[8].text = "Report"
            for label in textFields{
                label.font = UIFont.boldSystemFont(ofSize: 15)
            }
            textFields[7].isHidden = false
            textFields[8].isHidden = false
            actionButton.isHidden = true
            reportButton.isHidden = true

        }else{
            
            textFields[0].text = "\(caseForm!.caseAccession)"
            textFields[1].text = "\(caseForm!.firstName)"
            textFields[2].text = "\(caseForm!.lastName)"
            textFields[3].text = "24/Mar/1989"
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            textFields[4].text = "\(dateFormatter.string(from: caseForm!.dateCollected as Date))"
            if let recNo = caseForm?.medRecNo{
                textFields[5].text = "\(recNo)"
            }
            textFields[6].text = "\(caseForm!.statusFlag)"
            textFields[7].isHidden = true
            textFields[8].isHidden = true
            actionButton.isHidden = false
            reportButton.isHidden = false
            for label in textFields{
                label.font = UIFont.systemFont(ofSize: 15)
            }

        }
    }
}
