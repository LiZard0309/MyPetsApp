//
//  AnimalDetailsImageView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 28.01.25.
//

import SwiftUI

struct DetailsImageView: View {
    
    var animalPicture: Data?
    
    var body: some View {
        
            if let imageData = animalPicture,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .clipShape(Rectangle())
            } else {
                Image("PawPrint")
                    .resizable().scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .clipShape(Rectangle())
            }
        
    }
}

#Preview {
    DetailsImageView()
}
