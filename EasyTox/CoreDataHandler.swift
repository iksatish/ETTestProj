//
//  CoreDataHandler.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 3/20/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDatahandler:NSObject{
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var managedObjectContext: NSManagedObjectContext? {
        get {
            if let delegate = appDelegate {
                return delegate.managedObjectContext
            }
            return nil
        }
    }
    
    func saveNewPatient(_ patientForm:PatientForm){
        let patientInfo:PatientDetails =  NSEntityDescription.insertNewObject(forEntityName: "PatientDetails", into: managedObjectContext!) as! PatientDetails
        patientInfo.firstName = patientForm.firstName
        patientInfo.lastName = patientForm.lastName
        do{
            try self.managedObjectContext!.save()
        }
        catch{
            
        }
    }
    
    
    func fetchPatientDetails() -> [PatientDetails] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientDetails")
        _ = NSSortDescriptor(key: "firstName", ascending: true)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true)]
        //TODO: Add error handling
        var patients:[PatientDetails] = []
        do{
            patients =  try self.managedObjectContext!.fetch(fetchRequest) as! [PatientDetails]
            
        }catch{
            
        }
        return patients
    }


}
