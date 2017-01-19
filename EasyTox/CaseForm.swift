//
//  CaseForm.swift
//  ServiceApp
//
//  Created by Satish Kancherla on 7/28/16.
//  Copyright © 2016 Satish Kancherla. All rights reserved.
//

import Foundation


class CaseForm:NSObject{
    var caseId:NSInteger?
    var caseNo:NSString?
    var patientId:NSInteger?
    var patientName:NSString?
    var medRecNo:NSString?
    var caseType:NSString?
    var dateReceived:NSString?
    var dateCollected:NSString?
    var primaryPhysicianId:NSInteger?
    var primaryPhysicianName:NSString?
    var physicianLocation:NSString?
    var secondaryPhysicianId:NSInteger?
    var ccPhysicianId:NSInteger?
    var secondaryPhysician:NSString?
    var ccPhysician:NSString?
    var loggedInBy:NSString?
    var cancelCaseReason:NSString?
    var insuranceType:NSString?
    var profile:NSString?
    var statusFlag:NSString?
    var finalizedDate:NSString?
    var isCorrection: Bool?
    var isRevision: Bool?
    var isAmended:Bool?
    var amendedCaseOrderID:NSInteger?
    var dateCreated: NSString?
    var lastUpdated: NSString?
    var finalInterpretation:NSString?
    var showOnReport:Bool?
    var pathologistId: NSInteger?
    
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

class Pathologist: PersonalDetails{
    var pathId: NSInteger?
}

class PersonalDetails: NSObject{
    var firstName: NSString?
    var middleInitial: NSString?
    var lastName: NSString?
    var age: NSInteger?
    var gender: NSString?
    var dateOfBirth: NSString?
    var medRecNo: NSString?
    var address: Address?
    var contactNumber: NSString?
    var workNumber: NSString?
    var email: NSString?
    var medicalDegree: NSString?
    var salutation: NSString?
    var medicare_num: NSString?
    var medicaid_num: NSString?

}

class Patient: PersonalDetails{
    var patientId: NSInteger?
    var insurances: [Insurance]?
}

class Insurance: NSObject{
    var insuranceType: NSString?
    var insuranceCompanyCode: NSString?
    var insuranceCompanyName: NSString?
    var relation: NSString?
    var policyID: NSString?
    var groupName: NSString?
    var groupNumber: NSString?
    var validityOfPolicy: NSString?
    var insuredName: NSString?

}

class Address: NSObject{
    var address1: NSString?
    var address2: NSString?
    var city: NSString?
    var state: NSString?
    var zip: NSString?
}

class Physician: PersonalDetails{
    var phyId:NSInteger?
}

class PLocation: NSObject{
    
}
