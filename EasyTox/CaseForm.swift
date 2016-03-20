//
//  CaseForm.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import Foundation

class CaseForm:NSObject{
    
    var patientId:String = ""
    var caseId:String = ""
    var medicalRecordId:String = ""
    var dateCollected:NSDate = NSDate()
    var dateReceived:NSDate = NSDate()
    var caseType:String = ""
    var loggedInBy:String = ""
    var prescribedMedicne:String = ""
    var primaryPhysician:String = ""
    var secondaryPhysician:String = ""
    var ccPhysician:String = ""
    var compoundProfile:String = ""
    var pathologist:String = ""
    var finalInterpretation:String = ""
    var showOnReport:Bool = false
    var insuranceType:String = ""
    var injuryDate:NSDate?
    var claimNumber:String = ""


}