//
//  VetData.swift
//  MyPetsApp
//
//  Created by user on 24.01.25.
//

import Foundation
import CoreData

struct VetData {
    struct VetModel: Identifiable {
        var id: UUID = UUID()
        var name: String
        var address: String
        var telephoneNumber: String
    }
    
    static func createInitialVetData(context: NSManagedObjectContext) {
        //check if vets already exist in the database
        
        let fetchRequest = NSFetchRequest<Vet>(entityName: "Vet")
        fetchRequest.fetchLimit = 1
        
        do {
            let vetCount = try context.count(for: fetchRequest)
            
            if vetCount == 0 {
                //if there is no initial data in the database, add initial vets
                
                let vets = [
                    VetModel(name: "Dr.in Kitty Purrger", address: "Whisker-Straße 123, Wien", telephoneNumber: "0664/12342234"),
                    VetModel(name: "Dr. Wolf Barker", address: "Bark-Platz 1, Wiener Neustadt", telephoneNumber: "0660/1556789"),
                    VetModel(name: "Dr.in Bunny Hops", address: "Möhrenstraße 3, Wien", telephoneNumber: "0676/765974")
                ]
                
                for vetModel in vets {
                    let vet = Vet(context: context)
                    vet.name = vetModel.name
                    vet.address = vetModel.address
                    vet.telephoneNumber = vetModel.telephoneNumber
                }
                
                try context.save()
                print("Vet data successfully initialized")
            }
        } catch {
            print("Error initializing Vet data: \(error)")
        }
    }
    
    
}
