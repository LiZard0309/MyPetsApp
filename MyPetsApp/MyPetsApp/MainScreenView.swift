//
//  MainScreenView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 22.01.25.
//

import SwiftUI

struct MainScreenView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var petViewModel: PetViewModel
    
        
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var vetsList: FetchedResults<Vet>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var petsList: FetchedResults <Pet>
    
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(NSLocalizedString("MyPets", comment: ""))
                        .font(.title2.bold())
                        .foregroundColor(Color("TitleFontColor"))
                        .padding(.horizontal)
                    
                    if petsList.isEmpty {
                        Text(NSLocalizedString("NoPets", comment: ""))
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.horizontal)
                    } else {
                        LazyVStack {
                            ForEach(petsList, id: \.self) {pet in
                                NavigationLink(destination: AnimalDetailsView(pet: pet)) {
                                    HStack {
                                        AnimalPictureView(animalPicture: pet.animalPicture)
                                        AnimalListView(petName: pet.name, animalKind: pet.animalKind)
                                    }
                                    
                                    
                                }
                                .transition(.opacity.combined(with: .move(edge: .trailing)))
                                
                            }                            
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color("ListBackgroundColor"))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        
                    }
                    Text(NSLocalizedString("Vets", comment: ""))
                        .font(.title2.bold())
                        .foregroundColor(Color("TitleFontColor"))
                        .padding(.horizontal)
                                        
                    if vetsList.isEmpty {
                        Text(NSLocalizedString("NoVets", comment: ""))
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.horizontal)
                    }else{
                        LazyVStack{
                            ForEach(vetsList, id: \.self) {vet in
                                VetListView(
                                    vetName: vet.name,
                                    telephoneNumber: vet.telephoneNumber,
                                    address: vet.address
                                )
                            }
                        }
                        .padding()
                        .background(Color("ListBackgroundColor"))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .padding(.horizontal)
                    }
                    
                    
                    NavigationLink(destination: AddPetFormView()){
                        Text (NSLocalizedString("AddPet", comment: ""))
                            .padding()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("BackgroundColor"))
                            .frame(maxWidth: .infinity)
                            .background(Color("LinkColor"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .scaleEffect(scale)
                    .animation(.linear(duration: 2), value: scale)
                }
                .padding(.top, 20)
            }
        }
    }
    
        
}

/*#Preview {
 MainScreenView()
 }*/
