//
//  MedicationData.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 27.01.25.
//

import Foundation
import CoreData

struct MedicationData {
    static func createInitialMedicationData(context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<Medication>(entityName: "Medication")
        fetchRequest.fetchLimit = 1
        
        do {
            let medicationCount = try context.count(for: fetchRequest)
            
            if medicationCount == 0 {
                //if there is no initial data in the database, add initial vets
                
                let medications = [
                    ("Famotidine", NSLocalizedString("morning", comment: "")),
                    ("Doxepin", NSLocalizedString("evening", comment: "")),
                    ("Gabapentin", NSLocalizedString("evening", comment: "")),
                    ("Drontal Feline", NSLocalizedString("morning", comment: "")),
                    ("RodiCare", NSLocalizedString("evening", comment: ""))
                ]
                
                for medicationData in medications {
                    let medication = Medication(context: context)
                    medication.name = medicationData.0
                    medication.intakeTime = medicationData.1
                }
                
                try context.save()
                print("Medication data successfully initialized")
            }
        } catch {
            print("Error initializing Medication data: \(error)")
        }
    }
}
