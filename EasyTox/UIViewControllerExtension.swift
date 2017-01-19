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
    
    func randomString() -> String {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let upperBound = UInt32(alphabet.characters.count-1)
        return String((0..<4).map { _ -> Character in
            let randomNumber = Int(arc4random_uniform(upperBound))
            let start = alphabet.index(alphabet.startIndex, offsetBy: randomNumber)
            let end = alphabet.index(alphabet.startIndex, offsetBy: randomNumber+1)
            let range = start..<end
            if let charc = alphabet.substring(with: range).characters.first {
                return charc
            }else{
                return "C"
            }
        })
    }
    
    func randomNumber() -> String {
        let alphabet = "1234567890"
        let upperBound = UInt32(alphabet.characters.count-1)
        return String((0..<4).map { _ -> Character in
            let randomNumber = Int(arc4random_uniform(upperBound))
            let start = alphabet.index(alphabet.startIndex, offsetBy: randomNumber)
            let end = alphabet.index(alphabet.startIndex, offsetBy: randomNumber+1)
            let range = start..<end
            if let charc = alphabet.substring(with: range).characters.first {
                return charc
            }else{
                return "2"
            }
        })
    }

}
