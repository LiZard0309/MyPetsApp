//
//  Pet.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import Foundation
import SwiftUI

struct Pet {
    var name: String
    var animalType: String
    var furColor: String
    var animalBreed: String
    var medicationNeeds: Bool
    var lastVetCheckup: Date
    var animalPicture: String
    var petSound: String
    
}

struct AnimalPicture: View  {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Rectangle())
    }
}
