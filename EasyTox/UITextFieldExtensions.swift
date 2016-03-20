//
//  UITextFieldExtensions.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import Foundation
import UIKit

enum FieldType : Int{
    case TXTFIELD
    case LABEL
    case DROPDOWN
    case DROPDOWNREADABLE
}

extension UITextField{
    
    func setUpField(type:FieldType){
        let imgView = UIImageView(image: UIImage(named: "updown"))
        imgView.frame = CGRectMake(0, 0, 25, 20)
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        self.rightViewMode = UITextFieldViewMode.Always
        self.rightView = imgView
        switch type{
        case .LABEL:
            self.enabled = false
            self.rightView = nil
            break
        case .DROPDOWN:
            self.enabled = false
            self.userInteractionEnabled = true
            break
        case .DROPDOWNREADABLE:
            self.enabled = false
            break
        default:
            self.enabled = true
            break
        }
    }
    

}