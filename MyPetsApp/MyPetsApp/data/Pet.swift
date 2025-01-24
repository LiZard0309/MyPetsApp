//
//  PetsData.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 23.01.25.
//

import Foundation
import CoreData

@objc(Pet)
public class Pet: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var animalKind: String?
    @NSManaged public var age: Int?
    @NSManaged public var animalPicture: Data?
    @NSManaged public var breed: String?
    @NSManaged public var animalSound: String?
    @NSManaged public var nextCheckup: Date?
}
