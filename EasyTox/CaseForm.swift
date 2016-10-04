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
    var dateReceived:Date?
    var dateCollected:Date?
    var primaryPhysician:Physician?
    var secondaryPhysician:Physician?
    var ccPhysician:Physician?
    var medRecNo:NSString?
    var caseType:NSString?
    var loggedInBy:NSString?
    var cancelCaseReason:NSString?
    var pathologistID:NSString?
    var insuranceType:NSString?
    var injuryDate:Date?
    var claimNo:NSString?
    var statusFlag:NSString?
    var finalizedDate:Date?
}

class Physician:NSObject{
    var phyId:NSInteger?
    var salutation:NSString?
    var medicare_num:NSString?
    var medicaid_num:NSString?
    var upin_num:NSString?
    var state_license:NSString?
    var created_by:NSString?
    var created_date:Date?
    var modified_by:NSString?
    var modified_date:Date?
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
    var createdDate:Date?
    var modifiedBy:NSString?
    var modifiedDate:Date?
    
}

class CaseFormSimplified:NSObject{
    var caseAccession:NSString = ""
    var dateCollected:Date = Date()
    var firstName:NSString = ""
    var lastName:NSString = ""
    var dob:NSString = ""
    var medRecNo:NSString = ""
    var statusFlag:NSString = ""
    
}
