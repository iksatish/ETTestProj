//
//  PatientDetails+CoreDataProperties.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PatientDetails {

    @NSManaged var birthDate: NSDate?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
//    @NSManaged var reports: ReportDetails?

}
