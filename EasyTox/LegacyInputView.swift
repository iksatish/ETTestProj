//
//  LegacyInputView.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/8/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

@IBDesignable class LegacyInputView: UIView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var inputComponent: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LegacyInputView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.inputComponent.layer.cornerRadius = 4.0
        self.inputComponent.layer.borderColor = UIColor.grayColor().CGColor
        self.inputComponent.layer.borderWidth = 1.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    @IBInspectable var header:String = ""{
        didSet{
            self.headerLabel.text = header
        }
    }
    @IBInspectable var placeholder:String = ""{
        didSet{
            self.inputComponent.text = placeholder
        }
    }
    @IBInspectable var title:String = ""{
        didSet{
            
        }
    }

    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
    }


}
