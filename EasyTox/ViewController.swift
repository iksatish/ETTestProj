//
//  ViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 2/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.clearColor()
        self.loginView.layer.cornerRadius = 5.0
        self.loginView.layer.borderColor = UIColor.blackColor().CGColor
        self.loginView.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onPressingLogin(sender: UIButton) {
//        let vc:CollectionViewController = CollectionViewController()
//        UIApplication.sharedApplication().keyWindow?.rootViewController = vc;
    }


}

