//
//  AnimalDetailsView.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 24.01.25.
//

import SwiftUI

struct AnimalDetailsView: View {
    
    var pet: Pet
    
    @StateObject var audioModel = AudioModel()
    @EnvironmentObject var petViewModel: PetViewModel
    
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
                VStack (alignment: .center, spacing: 10) {
                    Text(NSLocalizedString("AnimalDetails", comment: ""))
                        .font(.title2.bold())
                        .foregroundColor(Color("TitleFontColor"))
                        .padding(.horizontal)
                    
                    DetailsImageView(animalPicture: pet.animalPicture)
                    
                    List {
                        
                        Section(header: Text(NSLocalizedString("PetName", comment: ""))){
                            Text(pet.name ?? NSLocalizedString("NoName", comment: ""))
                                .font(.system(size: 16))
                        }
                        
                        Section(header: Text(NSLocalizedString("PetKind", comment: ""))){
                            Text(pet.animalKind ?? NSLocalizedString("NoKind", comment: ""))
                                .font(.system(size: 16))
                        }
                        
                        Section(header: Text(NSLocalizedString("Age", comment: ""))){
                            Text(String(format: NSLocalizedString("Years", comment: ""), pet.age))
                                .font(.system(size: 16))
                        }
                        
                        Section(header: Text(NSLocalizedString("PetBreed", comment: ""))){
                            Text(pet.breed ?? NSLocalizedString("NoBreed", comment: ""))
                                .font(.system(size: 16))
                        }
                        Section(header: Text(NSLocalizedString("PetVet", comment: ""))){
                            Text(pet.vet?.name ?? NSLocalizedString("UnknownVet", comment: ""))
                                .font(.system(size: 16))
                        }
                        
                        Section(header: Text(NSLocalizedString("CheckupTime", comment: ""))){
                            if let nextCheckupDate = pet.nextCheckup {
                                Text(nextCheckupDate, style: .date)
                                    .font(.system(size: 16))
                            } else {
                                Text(NSLocalizedString("UnknownDate", comment: ""))
                                    .font(.system(size: 16))
                            }
                        }
                        
                        Section(header: Text(NSLocalizedString("Meds", comment: ""))){
                            Text(pet.medication?.name ?? NSLocalizedString("NoMeds", comment: ""))
                                .font(.system(size: 16))
                        }
                        
                        Section(header: Text(NSLocalizedString("PlaySound", comment: ""))){
                            
                            if let soundPath = pet.animalSound, let soundURL = URL(string: soundPath), FileManager.default.fileExists(atPath: soundURL.path) {
                                
                                Button {
                                    audioModel.startPlaying(soundURL: soundURL)
                                } label: {
                                    HStack {
                                        Image(systemName: "play.circle")
                                            .foregroundColor(.black)
                                        Text(NSLocalizedString("PlaySound", comment: ""))
                                            .foregroundColor(.black)
                                    }
                                }
                                .controlSize(.regular)
                                
                            } else {
                                Text("No sound available for this pet.")
                                    .foregroundColor(.gray)
                                    .padding(.top, 20)
                                
                            }
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(Color("ListBackgroundColor"))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    Button(NSLocalizedString("DeletePet", comment: "")){
                        showAlert = true
                    }
                    .padding()
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .foregroundColor(Color("BackgroundColor"))
                    .background(Color("LinkColor"))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    
                    .alert(NSLocalizedString("Delete", comment: ""), isPresented: $showAlert) {
                        Button(NSLocalizedString("Yes", comment: ""), role: .destructive) {
                            deletePetData()
                        }
                        Button(NSLocalizedString("Cancel", comment: ""), role: .cancel) {
                            showAlert = false
                        }
                    } message: {
                        Text(NSLocalizedString("ConfirmDelete", comment: ""))
                    }
                    
                   
                    Button(NSLocalizedString("TestNotification", comment: "")){
                        testNotification()
                    }
                    .padding()
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .foregroundColor(Color("BackgroundColor"))
                    .background(Color.gray)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                }
                
        
        }
    }
    
    func deletePetData(){
        petViewModel.deletePet(_petName: pet.name ?? "")
    }
    
    func testNotification(){
        //TODO implement function
    }
    
    
}



/*#Preview {
 AnimalDetailsView()
 }*/
