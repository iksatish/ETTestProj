//
//  ViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 2/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


protocol LoginDelegate{
    func onLogin()
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var userNameField: UITextField!
    var delegate:LoginDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.clear
        self.loginView.layer.cornerRadius = 5.0
        self.loginView.layer.borderColor = UIColor.black.cgColor
        self.loginView.layer.borderWidth = 1.0
        self.userNameField.target(forAction: "valueChangedForTextField:", withSender: self)
        self.userNameField.delegate = self
        self.passwordField.delegate = self
        let defaults = UserDefaults.standard
        if let uid = defaults.value(forKey: "usr") as? String, let pwd = defaults.value(forKey: "pwd") as? String{
            self.userNameField.text = uid
            self.passwordField.text = pwd
        }
    }

    @IBAction func onClickingForgotPwd(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: forgotPwdUrl)!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onPressingLogin(_ sender: UIButton) {
        let user = UserModel()
        user.userName = self.userNameField.text!
        user.password = self.passwordField.text!
        guard user.userName?.characters.count>5 else{
            self.errorLabel.isHidden = false
            self.errorLabel.text = "Username should be atleast 6 characters!"
            return
        }
        guard user.password?.characters.count>5 else{
            self.errorLabel.isHidden = false
            self.errorLabel.text = "Password should be atleast 6 characters!"
            return
        }
        let ser = ServiceRequest()
        let dict = NSMutableDictionary()
        let auths = "\(user.userName):\(user.password)"
        let authData = auths.data(using: String.Encoding.utf8)
        dict.setValue(user.userName, forKey: "username")
        dict.setValue(user.password, forKey: "password")
        let req = NSMutableURLRequest(url: URL(string: "http://bmtechsol.com:8080/easytox/api/login")!)
        req.httpBody = encodeJSON(dict )
        
        req.httpMethod  = "POST"
        req.setValue("Basic \(authData?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters))", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.showProgressView("Logging In")
        weak var weakself = self
        
        ser.doServiceRequest(req as URLRequest, failure: { (error) in
            DispatchQueue.main.sync(execute: {
                weakself?.errorLabel.isHidden = false
                weakself?.errorLabel.text = "Invalid Credentials!"
                weakself?.hideProgressView()
            })
            }, success: { (data) in
                DispatchQueue.main.sync(execute: {
                    weakself?.hideProgressView()
                    weakself?.errorLabel.isHidden = true
                    weakself?.dismiss(animated: true, completion: nil)
                    weakself?.parseData(data!)
                    weakself?.delegate?.onLogin()
                })
            })
    }
    
    func parseData(_ data:NSDictionary){
        
        if let jsonData = data.value(forKey: "jsonData") {
            if let token = (jsonData as AnyObject).value(forKey: "access_token"){
                let defaults = UserDefaults.standard
                defaults.setValue(token, forKey: "EX-Token")
                defaults.setValue(self.userNameField.text, forKey: "usr")
                defaults.setValue(self.passwordField.text, forKey: "pwd")
                defaults.synchronize()
            }
        }
    }
    
    

}

