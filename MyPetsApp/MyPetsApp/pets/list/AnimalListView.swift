//
//  AnimalImageView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 24.01.25.
//

import SwiftUI

struct AnimalListView: View {
    
    var petName: String?
    var animalKind: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(petName ?? NSLocalizedString("NoName", comment: ""))
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
                .foregroundColor(Color.black)
            Text(animalKind ?? NSLocalizedString("NoKind", comment: ""))
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
            .foregroundColor(Color.black)
            Divider()
        }
    }
}

/*#Preview {
    AnimalListView(pet: <#T##Pet#>)
}*/
