//
//  ViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 2/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

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
        self.view.backgroundColor = UIColor.clearColor()
        self.loginView.layer.cornerRadius = 5.0
        self.loginView.layer.borderColor = UIColor.blackColor().CGColor
        self.loginView.layer.borderWidth = 1.0
        self.userNameField.targetForAction("valueChangedForTextField:", withSender: self)
        self.userNameField.delegate = self
        self.passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onPressingLogin(sender: UIButton) {
        let user = UserModel()
        user.userName = self.userNameField.text!
        user.password = self.passwordField.text!
        guard user.userName?.characters.count>5 else{
            self.errorLabel.hidden = false
            self.errorLabel.text = "Username should be atleast 6 characters!"
            return
        }
        guard user.password?.characters.count>5 else{
            self.errorLabel.hidden = false
            self.errorLabel.text = "Password should be atleast 6 characters!"
            return
        }
        let ser = ServiceRequest()
        let dict = NSMutableDictionary()
        let auths = "\(user.userName):\(user.password)"
        let authData = auths.dataUsingEncoding(NSUTF8StringEncoding)
        dict.setValue(user.userName, forKey: "username")
        dict.setValue(user.password, forKey: "password")
        let req = NSMutableURLRequest(URL: NSURL(string: "http://bmtechsol.com:8080/easytox/api/login")!)
        req.HTTPBody = encodeJSON(dict )
        
        req.HTTPMethod  = "POST"
        req.setValue("Basic \(authData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength))", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.showProgressView("Logging In")
        weak var weakself = self
        
        ser.doServiceRequest(req, failure: { (error) in
            dispatch_sync(dispatch_get_main_queue(), {
                weakself?.errorLabel.hidden = false
                weakself?.errorLabel.text = "Invalid Credentials!"
                weakself?.hideProgressView()
            })
            }, success: { (data) in
                dispatch_sync(dispatch_get_main_queue(), {
                    weakself?.hideProgressView()
                    weakself?.errorLabel.hidden = true
                    weakself?.dismissViewControllerAnimated(true, completion: nil)
                    weakself?.parseData(data!)
                    weakself?.delegate?.onLogin()
                })
            })
    }
    
    func parseData(data:NSDictionary){
        
        if let jsonData = data.valueForKey("jsonData") {
            if let token = jsonData.valueForKey("access_token"){
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setValue(token, forKey: "EX-Token")
                defaults.synchronize()
            }
        }
    }
    
    

}

