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
                
                List{
                    ForEach(petsList) {pet in
                        HStack {
                            NavigationLink(destination: AnimalDetailsView()) {
                                AnimalPictureView(animalPicture: pet.animalPicture)
                                AnimalListView(petName: pet.name, animalKind: pet.animalKind)
                            }
                        }
                    }
                }
                
                NavigationLink(destination: AddPetFormView()){
                    Text (NSLocalizedString("AddPet", comment: ""))
                        .padding()
                        .font(.system(size: 18, weight: .bold)).foregroundColor(Color("BackgroundColor"))
                        .frame(maxWidth: .infinity)
                        .background(Color("LinkColor"))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 30)
                
                
            }
            
        }
        
    }
}

#Preview {
    MainScreenView()
}
