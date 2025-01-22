//
//  MainScreenView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        NavigationView(){
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
              
            
                VStack {
                    Text(NSLocalizedString("MyPets", comment: ""))
                        .font(.largeTitle.bold()).foregroundColor(Color("TitleFontColor"))
                                            
                    NavigationLink(destination: AddPetFormView()){
                        Text (NSLocalizedString("AddPet", comment: ""))
                            .padding(20)
                            .font(.system(size: 18, weight: .bold)).foregroundColor(Color("LinkColor"))
                            
                    }
                }
            }
        }
        .navigationTitle("Main")
    }
}

/*#Preview {
    MainScreenView()
}*/
