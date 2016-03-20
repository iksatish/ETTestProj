//
//  CustomTextFieldView.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/7/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit
enum ViewType : Int{
    case TXTFIELD
    case LABEL
    case DROPDOWN
    case DROPDOWNREADABLE
}

@IBDesignable class CustomTextFieldView: UIView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var curTextField: UITextField!
    var controlTitle:String = ""
    var currentViewType:ViewType = ViewType.TXTFIELD
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
        let nib = UINib(nibName: "CustomTextFieldView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        self.errorLabel.text = ""
        self.headerLabel.text = header
        self.view.layer.cornerRadius = 3.0
        self.curTextField.placeholder = self.placeholder

    }
    @IBInspectable var header:String = ""{
        didSet{
            self.headerLabel.text = header
        }
    }
    @IBInspectable var placeholder:String = ""{
        didSet{
            self.curTextField.placeholder = self.placeholder
        }
    }
    @IBInspectable var title:String = ""{
        didSet{
            self.controlTitle = title
        }
    }
    @IBInspectable var textValue:String = ""{
        didSet{
            self.curTextField.text = textValue
        }
    }
    @IBInspectable var type:Int = 0{
        didSet{
            switch type{
            case 1:
                self.currentViewType = ViewType.LABEL
                self.curTextField.enabled = false
                break
            case 2:
                self.setupDropDownField(true)
                break
            case 3:
                self.setupDropDownField(false)
                break
            default:
                self.currentViewType = ViewType.TXTFIELD
            }
        }
    }
    
    func setupDropDownField(isReadable:Bool){
        self.currentViewType = ViewType.DROPDOWN
        let imgView = UIImageView(image: UIImage(named: "updown"))
        imgView.frame = CGRectMake(0, 0, 25, 20)
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        self.curTextField.rightViewMode = UITextFieldViewMode.Always
        self.curTextField.rightView = imgView
        self.curTextField.enabled = false
        self.curTextField.userInteractionEnabled = isReadable
//        if (isReadable){
//            let tapRecognizer = UITapGestureRecognizer(target: self, action: <#T##Selector#>)
//        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.view.layer.cornerRadius = 3.0
        
        
    }
    
    

}
