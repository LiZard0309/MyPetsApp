//
//  VetData.swift
//  MyPetsApp
//
//  Created by user on 24.01.25.
//

import Foundation
import CoreData

struct VetData {
    static func createInitialVetData(context: NSManagedObjectContext) {
        //check if vets already exist in the database
        
        let fetchRequest = NSFetchRequest<Vet>(entityName: "Vet")
        fetchRequest.fetchLimit = 1
        
        do {
            let vetCount = try context.count(for: fetchRequest)
            
            if vetCount == 0 {
                //if there is no initial data in the database, add initial vets
                
                let vets = [
                    ("Dr.in Kitty Purrger", "Whisker-Straße 123, Wien", "0664/12342234"),
                    ("Dr. Wolf Barker", "Bark-Platz 1, Wiener Neustadt", "0660/1556789"),
                    ("Dr.in Bunny Hops", "Möhrenstraße 3, Wien", "0676/765974")
                ]
                
                for vetData in vets {
                    let vet = Vet(context: context)
                    vet.name = vetData.0
                    vet.address = vetData.1
                    vet.telephoneNumber = vetData.2
                }
                
                try context.save()
                print("Vet data successfully initialized")
            }
        } catch {
            print("Error initializing Vet data: \(error)")
        }
    }
    
    
}
