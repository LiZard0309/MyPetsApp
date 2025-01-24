//
//  MainScreenView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import SwiftUI

struct MainScreenView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //@State var petsList: [Pet] = []
    
    @FetchRequest(entity: Pet.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Pet.name, ascending: true)]) var petsList: FetchedResults<Pet>
    //updates List automatically and sorts it after pets' names
    
    
    var body: some View {
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
           
            
                VStack {
                    
                    Text(NSLocalizedString("MyPets", comment: ""))
                        .font(.largeTitle.bold()).foregroundColor(Color("TitleFontColor"))
                    
                    List(petsList, id: \.self){ pet in
                            HStack {
                                NavigationLink(destination: AnimalDetailsView()) {
                                    AnimalPictureView(pet: pet)
                                    AnimalListView(pet: pet)
                                }
                            }}
                    }
                                            
                    NavigationLink(destination: AddPetFormView()){
                        Text (NSLocalizedString("AddPet", comment: ""))
                            .padding(20)
                            .font(.system(size: 18, weight: .bold)).foregroundColor(Color("LinkColor"))
                            
                    }
                }
                
        }
        
    
}

#Preview {
    MainScreenView()
}
