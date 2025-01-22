//
//  Pet.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import Foundation
import SwiftUI

struct AnimalPictureView: View  {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Rectangle())
    }
}

/*struct AnimalPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPictureView(imageName: <#T##String#>)
    }
}*/
