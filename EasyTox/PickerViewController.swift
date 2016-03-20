//
//  PickerViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/19/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissPickerView:"))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func closePickerView(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissPickerView(sender:UIGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
