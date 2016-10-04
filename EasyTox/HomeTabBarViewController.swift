//
//  HomeTabBarViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/7/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController,LoginDelegate {
    
    @IBOutlet weak var headerView: UIView!
    var blurEffectView:UIVisualEffectView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserDefaults.standard.value(forKey: "EX-Token"){
            NotificationCenter.default.post(name: Notification.Name(rawValue: kFetchListNotification), object: nil)
        }else{
            self.forceLogin()
        }
    }
    func forceLogin(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView!.alpha = 0.0
        view.addSubview(blurEffectView!)
        UIView.animate(withDuration: 0.5, animations: {
            self.blurEffectView!.alpha = 0.9
            }, completion: { _ in
                let vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeviewcontrollerIdentifier") as! ViewController
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
        })
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , I think the default value is around 50 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.tabBar.frame = tabFrame
    }
    
    func onLogin() {
        if let _ = blurEffectView{
            self.blurEffectView!.removeFromSuperview()
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: kFetchListNotification), object: nil)
    }
    
    func gatherData(_ array:NSMutableArray){
        let vc = self.viewControllers![0] as? CaseListViewController
        vc?.reloadTableWithData(array)
    }
    
}
