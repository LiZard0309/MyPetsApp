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
                        
                        Section(header: Text(NSLocalizedString("IntakeTime", comment: ""))){
                            Text(pet.medication?.intakeTime ?? NSLocalizedString("NoMeds", comment: ""))
                                .font(.system(size: 16))
                        }
                        
                        Section(header: Text(NSLocalizedString("PlaySound", comment: ""))){
                            
                            if let soundFilename = pet.animalSound,
                               let soundURL = Bundle.main.url(forResource: soundFilename, withExtension: nil) {
                                
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
                                Text(NSLocalizedString("NoSoundAvailable", comment: ""))
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
                        setupCheckupTestNotification()
                    }
                    .padding()
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .foregroundColor(Color("BackgroundColor"))
                    .background(Color("SecondaryButton"))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                }
                
        
        }
    }
    
    func deletePetData(){
        petViewModel.deletePet(_petName: pet.name ?? "")
    }
    
    func setupCheckupTestNotification(){
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("CheckupReminder", comment: "")
        content.body = String(format: NSLocalizedString("CheckupText", comment: ""), pet.name ?? NSLocalizedString("Unknown", comment: ""))
        content.categoryIdentifier = "CHECKUP_DATE_TEST"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let notificationIdentifier = "checkupTestNotification-\(String(describing: pet.name))"
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION", title: NSLocalizedString("Ok", comment: ""), options: [])
        
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION", title: NSLocalizedString("Cancel", comment: ""), options: [.destructive])
        
        let checkupCategory = UNNotificationCategory(identifier: "CHECKUP_DATE", actions: [acceptAction, declineAction], intentIdentifiers: [], options: .customDismissAction)
        
        UNUserNotificationCenter.current().add(request)
    }
 
}



/*#Preview {
 AnimalDetailsView()
 }*/
