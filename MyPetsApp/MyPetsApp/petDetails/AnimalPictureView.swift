//
//  Pet.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import Foundation
import SwiftUI

struct AnimalPictureView: View  {
    
    var animalPicture: Data?
    
    var body: some View {
        if let imageData = animalPicture,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else {
            Image("PawPrint")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
    }
}

/*struct AnimalPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPictureView(pet: <#T##Pet#>)
    }
}*/
