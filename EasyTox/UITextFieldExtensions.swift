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
    case txtfield
    case label
    case dropdown
    case dropdownreadable
}

extension UITextField{
    
    func setUpField(_ type:FieldType){
        let imgView = UIImageView(image: UIImage(named: "updown"))
        imgView.frame = CGRect(x: 0, y: 0, width: 25, height: 20)
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        self.rightViewMode = UITextFieldViewMode.always
        self.rightView = imgView
        switch type{
        case .label:
            self.isEnabled = false
            self.rightView = nil
            break
        case .dropdown:
            self.isEnabled = false
            self.isUserInteractionEnabled = true
            break
        case .dropdownreadable:
            self.isEnabled = false
            break
        default:
            self.isEnabled = true
            break
        }
    }
    

}
