//
//  UIViewControllerExtension.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 7/13/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import Foundation

extension UIViewController{
    
    func showProgressView(_ labelText:String){
        let progressView = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressView.label.text = labelText ?? "Loading"
    }
    
    func hideProgressView(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    func showAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
