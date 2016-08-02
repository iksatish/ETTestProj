//
//  GlobalConstants.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/5/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

let globalBackGroundColor:UIColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
let headerCellIdentifier = "headerCellIdentifier"
let singleCellIdentifier = "singleCellIdentifier"
let doubleCellIdentifier = "doubleCellIdentifier"
let patientInfoCellIdentifier = "patientInfoCellIdentifier"

// CornerRadius & shadow
let kGlobalCornerRadius:CGFloat = 3.5
let kProgressMeterConrnerRadius:CGFloat = 6
let kGlobalShadowColor:CGColor = UIColor.lightGrayColor().CGColor
let kGlobalShadowRadius:CGFloat = 0.5
let kGlobalShadowOffset:CGSize = CGSizeMake(0.5, 1)
let kGlobalShadowOpacity:Float = 0.5
let patientFormIdentifier = "patient"
let physicianFormIdentifier = "physician"
let tripleCellIdentifier = "tripleCellIdentifier"
let dobAgeCellIdentifier = "dobAgeCellIdentifier"
let legacyCellIdentifier = "legacyCellIdentifier"
let insuranceCellIdentifier = "insuranceCellIdentifier"
let insButtonsCellIdentifier = "insButtonsCellIdentifier"

let coredatahandler = CoreDatahandler()

class Util:NSObject{
    class func dateFor(timeStamp: String) -> NSDate
    {
        //Create Date Formatter
        let dateFormatter = NSDateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.dateFromString(timeStamp)!
        
        //Return Parsed Date
        return dateFromString
    }
    class func dateFors(timeStamp: String) -> NSDate
    {
        let formater = NSDateFormatter()
        formater.dateFormat = "HH:mm:ss:SSS - MMM dd, yyyy"
        return formater.dateFromString(timeStamp)!
    }
    
    
    class func timeStampFor(date: NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss:SSS - MMM dd, yyyy"
        
        return dateFormatter.stringFromDate(date)
    }
}
