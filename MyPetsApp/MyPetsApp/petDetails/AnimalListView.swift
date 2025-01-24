//
//  AnimalImageView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 24.01.25.
//

import SwiftUI

struct AnimalListView: View {
    let pet: Pet
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pet.name ?? NSLocalizedString("NoName", comment: ""))
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
            Text(pet.animalKind ?? NSLocalizedString("NoKind", comment: ""))
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AnimalListView(pet: <#T##Pet#>)
}
