//
//  MedicationData.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 27.01.25.
//

import Foundation
import CoreData

struct MedicationData {
    struct MedicationModel: Identifiable {
        var id: UUID = UUID()
        var name: String
        var intakeTime: String
    }
    
    static func createInitialMedicationData(context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<Medication>(entityName: "Medication")
        fetchRequest.fetchLimit = 1
        
        do {
            let medicationCount = try context.count(for: fetchRequest)
            
            if medicationCount == 0 {
                //if there is no initial data in the database, add initial vets
                
                let medications = [
                    MedicationModel(name: "Famotidine", intakeTime: NSLocalizedString("morning", comment: "")),
                    MedicationModel(name: "Doxepin", intakeTime: NSLocalizedString("evening", comment: "")),
                    MedicationModel(name: "Gabapentin", intakeTime: NSLocalizedString("evening", comment: "")),
                    MedicationModel(name: "Drontal Feline", intakeTime: NSLocalizedString("morning", comment: "")),
                    MedicationModel(name: "RodiCare", intakeTime: NSLocalizedString("evening", comment: ""))
                ]
                
                for medicationModel in medications {
                    let medication = Medication(context: context)
                    medication.name = medicationModel.name
                    medication.intakeTime = medicationModel.intakeTime
                }
                
                try context.save()
                print("Medication data successfully initialized")
            }
        } catch {
            print("Error initializing Medication data: \(error)")
        }
    }
}
