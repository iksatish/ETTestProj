//
//  HomeTabBarViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/7/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.forceLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forceLogin(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.0
        view.addSubview(blurEffectView)
        UIView.animateWithDuration(0.5, animations: {
            blurEffectView.alpha = 0.8
            }, completion: { _ in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homeviewcontrollerIdentifier")
                self.presentViewController(vc, animated: true, completion: nil)
        })
    }

    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , I think the default value is around 50 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.tabBar.frame = tabFrame
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
