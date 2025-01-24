//
//  VetListView.swift
//  MyPetsApp
//
//  Created by user on 24.01.25.
//

import SwiftUI

struct VetListView: View {
    var vetName: String?
    var telephoneNumber: String?
    var address: String?
    
    var body: some View {
        VStack {
            Text(vetName ?? NSLocalizedString("NoName", comment: ""))
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
            HStack{
                Image(systemName: "phone")
                    .resizable()
                    .frame(width: 10, height: 10)
                Text(telephoneNumber ?? NSLocalizedString("NoNumber", comment: ""))
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
            HStack{
                Image(systemName: "envelope")
                    .resizable()
                    .frame(width: 10, height: 10)
                Text(address ?? NSLocalizedString("NoAddress", comment: ""))
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
           Divider()
        }
    }
}

struct VetListView_Previews: PreviewProvider {
    static var previews: some View {
        VetListView()
    }
}
