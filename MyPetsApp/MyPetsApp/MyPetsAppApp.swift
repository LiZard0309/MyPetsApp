//
//  MyPetsAppApp.swift
//  MyPetsApp
//
//  Created by user on 20.01.25.
//

import SwiftUI
import CoreData

@main
struct MyPetsAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(PetViewModel(context: persistenceController.container.viewContext))
            
                .onAppear{
                    VetData.createInitialVetData(context: persistenceController.container.viewContext)
                    MedicationData.createInitialMedicationData(context: persistenceController.container.viewContext)
                    let petViewModel = PetViewModel(context: persistenceController.container    .viewContext)
                    petViewModel.preloadPets()
                }
        }
    }
}
