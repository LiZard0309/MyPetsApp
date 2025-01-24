//
//  PersistenceController.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 23.01.25.
//

import Foundation
import CoreData

class PersistenceController {

    static let shared = PersistenceController()
        
    let container: NSPersistentContainer
  
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "PetsModel")
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        save()
    }
    
    func save(){
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
        
    }
}
