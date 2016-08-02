//
//  CaseForm.swift
//  ServiceApp
//
//  Created by Satish Kancherla on 7/28/16.
//  Copyright © 2016 Satish Kancherla. All rights reserved.
//

import Foundation


class CaseForm:NSObject{
    var caseOrderId:NSInteger?
    var caseNo:NSString?
    var caseAccession:NSString?
    var dateReceived:NSDate?
    var dateCollected:NSDate?
    var primaryPhysician:Physician?
    var secondaryPhysician:Physician?
    var ccPhysician:Physician?
    var medRecNo:NSString?
    var caseType:NSString?
    var loggedInBy:NSString?
    var cancelCaseReason:NSString?
    var pathologistID:NSString?
    var insuranceType:NSString?
    var injuryDate:NSDate?
    var claimNo:NSString?
    var statusFlag:NSString?
    var finalizedDate:NSDate?
}

class Physician:NSObject{
    var phyId:NSInteger?
    var salutation:NSString?
    var medicare_num:NSString?
    var medicaid_num:NSString?
    var upin_num:NSString?
    var state_license:NSString?
    var created_by:NSString?
    var created_date:NSDate?
    var modified_by:NSString?
    var modified_date:NSDate?
    var user:UserObject?
}

class UserObject:NSObject{
    var id:NSInteger?
    var username:NSString?
    var firstName:NSString?
    var lastName:NSString?
    var email:NSString?
    var userType:NSString?
    var contact:NSString?
    var createdBy:NSString?
    var createdDate:NSDate?
    var modifiedBy:NSString?
    var modifiedDate:NSDate?
    
}

class CaseFormSimplified:NSObject{
    var caseAccession:NSString = ""
    var dateCollected:NSDate = NSDate()
    var firstName:NSString = ""
    var lastName:NSString = ""
    var dob:NSString = ""
    var medRecNo:NSString = ""
    var statusFlag:NSString = ""
    
}