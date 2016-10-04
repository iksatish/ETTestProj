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
let kGlobalShadowColor:CGColor = UIColor.lightGray.cgColor
let kGlobalShadowRadius:CGFloat = 0.5
let kGlobalShadowOffset:CGSize = CGSize(width: 0.5, height: 1)
let kGlobalShadowOpacity:Float = 0.5
let patientFormIdentifier = "patient"
let physicianFormIdentifier = "physician"
let tripleCellIdentifier = "tripleCellIdentifier"
let dobAgeCellIdentifier = "dobAgeCellIdentifier"
let legacyCellIdentifier = "legacyCellIdentifier"
let insuranceCellIdentifier = "insuranceCellIdentifier"
let insButtonsCellIdentifier = "insButtonsCellIdentifier"
let kFetchListNotification = "FetchCaseListNotification"

let coredatahandler = CoreDatahandler()

class Util:NSObject{
    class func dateFor(_ timeStamp: String) -> Date
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: timeStamp)!
        
        //Return Parsed Date
        return dateFromString
    }
    class func dateFors(_ timeStamp: String) -> Date
    {
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm:ss:SSS - MMM dd, yyyy"
        return formater.date(from: timeStamp)!
    }
    
    
    class func timeStampFor(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss:SSS - MMM dd, yyyy"
        
        return dateFormatter.string(from: date)
    }
}
