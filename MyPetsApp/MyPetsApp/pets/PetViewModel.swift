//
//  PetViewModel.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 27.01.25.
//

import Foundation
import CoreData
import PhotosUI

class PetViewModel: ObservableObject {
    private let managedObjectContext: NSManagedObjectContext
    
    @Published var petList: [Pet] = []
    
    init(context: NSManagedObjectContext){
        self.managedObjectContext = context
        fetchPets()
    }
    
    
    func fetchPets(){
        //fetchPets from core data
        
        let fetchRequest = NSFetchRequest<Pet>(entityName: "Pet")
        
        do {
            petList = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func addPet(
        petName: String,
        petKind: String,
        petAge: Int16,
        petBreed: String,
        vet: Vet?,
        nextCheckup: Date,
        getsMedication: Bool,
        medication: Medication?,
        animalImage: Data,
        animalSound: String
    )
    {
       let newPet = Pet(context: managedObjectContext)
        newPet.id = UUID()
        newPet.name = petName
        newPet.animalKind = petKind
        newPet.age = petAge
        newPet.breed = petBreed
        newPet.nextCheckup = nextCheckup
        newPet.getsMedication = getsMedication
        newPet.animalPicture = animalImage
        newPet.animalSound = animalSound
        newPet.vet = vet
        newPet.medication = medication
        
        
        do {
            try managedObjectContext.save()
            fetchPets()
            print("New Pet \(petName) added successfully")
            print("Saved sound path: \(newPet.animalSound ?? "No path saved")")
        } catch {
            print("Error saving pet: \(error)")
        }
        
    }
    
    func deletePet(_petName: String){
        let request = NSFetchRequest<Pet>(entityName: "Pet")
        
        do {
            let pet = try
            managedObjectContext.fetch(request).first(where: {$0.name == _petName})
            
            managedObjectContext.delete(pet!)
            
            if managedObjectContext.hasChanges {
                try managedObjectContext.save()
                fetchPets()
            }
        } catch {
            print ("Error deleting pets: \(error)")
        }
        
        
    }
    
    func preloadPets(){
        let petFetchRequest = NSFetchRequest<Pet>(entityName: "Pet")
        petFetchRequest.fetchLimit = 1
        
        //PRELOAD PET IMAGES
        guard let imageWillow = UIImage(named: "CatOne"),
              let imageDataWillow = imageWillow.jpegData(compressionQuality: 1.0) else {
            print("Error loading image data from assets")
            return
        }
        
        guard let imageWesley = UIImage(named: "CatTwo"),
              let imageDataWesley = imageWesley.jpegData(compressionQuality: 1.0) else {
            print("Error loading image data from assets")
            return
        }
        
        guard let imagePoirot = UIImage(named: "BunnyOne"),
              let imageDataPoirot = imagePoirot.jpegData(compressionQuality: 1.0) else {
            print("Error loading image data from assets")
            return
        }
        
        //PRELOAD PET SOUNDS
        /*guard let soundURLPurring = Bundle.main.url(forResource: "cat-purring", withExtension: "mp3") else {
            fatalError("cat-purring.mp3 not found in bundle")
        }
        
        guard let soundURLMeowing = Bundle.main.url(forResource: "cat-meow", withExtension: "mp3") else {
            fatalError("cat-meow.mp3 not found in bundle")
        }
        
        guard let soundURLBunny = Bundle.main.url(forResource: "rabbit-squeaks", withExtension: "mp3") else {
            fatalError("rabbit-squeaks.mp3 not found in bundle")
        }*/
        
        
        
        //PRELOAD PET VETS
        let vetFetchRequest = NSFetchRequest<Vet>(entityName: "Vet")
        vetFetchRequest.predicate = NSPredicate(format: "name == %@", "Dr.in Kitty Purrger")
        
        let vetCat: Vet?
        do {
            vetCat = try managedObjectContext.fetch(vetFetchRequest).first
        } catch {
            print ("Error fetching vet: \(error)")
            vetCat = nil
        }
        
        
        vetFetchRequest.predicate = NSPredicate(format: "name == %@", "Dr.in Bunny Hops")
        
        let vetBunny: Vet?
        do {
            vetBunny = try managedObjectContext.fetch(vetFetchRequest).first
        } catch {
            print ("Error fetching vet: \(error)")
            vetBunny = nil
        }
        
        //PRELOAD PET MEDICATION
        let medsFetchRequest = NSFetchRequest<Medication>(entityName: "Medication")
        medsFetchRequest.predicate = NSPredicate(format: "name == %@", "Drontal Feline")
        
        let medicationWillow: Medication?
        do {
            medicationWillow = try managedObjectContext.fetch(medsFetchRequest).first
        } catch {
            print ("Error fetching Medication: \(error)")
            medicationWillow = nil
        }
        
        medsFetchRequest.predicate = NSPredicate(format: "name == %@", "Gabapentin")
        
        let medicationWesley: Medication?
        do {
            medicationWesley = try managedObjectContext.fetch(medsFetchRequest).first
        } catch {
            print ("Error fetching Medication: \(error)")
            medicationWesley = nil
        }
        
        medsFetchRequest.predicate = NSPredicate(format: "name == %@", "RodiCare")
        
        let medicationPoirot: Medication?
        do {
            medicationPoirot = try managedObjectContext.fetch(medsFetchRequest).first
        } catch {
            print ("Error fetching Medication: \(error)")
            medicationPoirot = nil
        }
        
        //ADD PETS
        
        do {
            let petCount = try managedObjectContext.count(for: petFetchRequest)
            
            if petCount == 0 {
                
                addPet(
                    petName: "Willow",
                    petKind: NSLocalizedString("Cat", comment: ""),
                    petAge: 8,
                    petBreed: NSLocalizedString("EuropShorthair", comment: ""),
                    vet: vetCat,
                    nextCheckup: Date(timeIntervalSince1970: 1739535752),
                    getsMedication: true,
                    medication: medicationWillow,
                    animalImage: imageDataWillow,
                    animalSound: "cat-purring.mp3"
                )
                
                addPet(
                    petName: "Wesley",
                    petKind: NSLocalizedString("Cat", comment: ""),
                    petAge: 5,
                    petBreed: NSLocalizedString("EuropShorthair", comment: ""),
                    vet: vetCat,
                    nextCheckup: Date(timeIntervalSince1970: 1740831752),
                    getsMedication: true,
                    medication: medicationWesley,
                    animalImage: imageDataWesley,
                    animalSound: "cat-meow.mp3"
                )
                
                addPet(
                    petName: "Poirot",
                    petKind: NSLocalizedString("Bunny", comment: ""),
                    petAge: 8,
                    petBreed: NSLocalizedString("DwarfRabbit", comment: ""),
                    vet: vetBunny,
                    nextCheckup: Date(timeIntervalSince1970: 1738326152),
                    getsMedication: true,
                    medication: medicationPoirot,
                    animalImage: imageDataPoirot,
                    animalSound: "rabbit-squeaks.mp3"
                )
            }
        } catch {
            print ("Error initializing Pet data: \(error)")
        }
    }
}
