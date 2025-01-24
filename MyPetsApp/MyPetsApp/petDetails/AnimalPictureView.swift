//
//  Pet.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import Foundation
import SwiftUI

struct AnimalPictureView: View  {
    
    let pet: Pet
    
    var body: some View {
        if let imageData = pet.animalPicture,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 50, height: 100)
                .clipShape(Circle())
        } else {
            Image("PetOutline")
                .resizable()
                .frame(width: 50, height: 100)
                .clipShape(Circle())
        }
    }
}

struct AnimalPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPictureView(pet: <#T##Pet#>)
    }
}
