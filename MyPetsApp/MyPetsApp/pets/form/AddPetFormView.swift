//
//  AddPetFormView.swift
//  MyPetsApp
//
//  Created by user on 22.01.25.
//

import SwiftUI
import PhotosUI

struct AddPetFormView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var petViewModel: PetViewModel
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var imageView: Image?
    @State var animalImageData: Data? = nil
    
    @StateObject var audioModel = AudioModel()
    
    @State var petName: String = ""
    @State var petAge: Int16 = 0
    @State var petSelection: String = NSLocalizedString("Other", comment: "")
    @State var petBreed: String = ""
    @State var nextCheckup: Date = Date()
    @State var getsMedication: Bool = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var vetList: FetchedResults<Vet>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var medList: FetchedResults<Medication>
    
    
    @State var vetSelection: Vet? = nil
    @State var medSelection: Medication? = nil
    
    let petKinds = [
        NSLocalizedString("Cat", comment: ""),
        NSLocalizedString("Dog", comment: ""),
        NSLocalizedString("Bunny", comment: ""),
        NSLocalizedString("Bird", comment: ""),
        NSLocalizedString("GuineaPig", comment: ""),
        NSLocalizedString("Turtle", comment: ""),
        NSLocalizedString("Mouse", comment: ""),
        NSLocalizedString("Other", comment: "")
    ]
    
    
    var body: some View {
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 20) {
                Text(NSLocalizedString("AddNew", comment: ""))
                    .font(.title2.bold())
                    .foregroundColor(Color("TitleFontColor"))
                    .padding(.horizontal)
                
                
                List {
                    
                    imageView?
                        .resizable()
                        .scaledToFit()
                    PhotosPicker(selection: $selectedPhoto) {
                        Label(NSLocalizedString("AnimalPhoto", comment: ""), systemImage: "photo")
                            .foregroundColor(Color("LinkColor"))
                    }
                    
                    TextField(NSLocalizedString("PetName", comment: ""), text: $petName)
                    
                    Stepper(String(format: NSLocalizedString("PetAge", comment: ""), petAge), value: $petAge, in: 0...30)
                    
                    
                    Picker(NSLocalizedString("PetKind", comment: ""), selection: $petSelection){
                        ForEach(petKinds, id: \.self) { kind in
                            Text(kind)
                        }
                    }
                    
                    TextField(NSLocalizedString("PetBreed", comment: ""), text: $petBreed)
                    
                    Picker(NSLocalizedString("PetVet", comment: ""), selection: $vetSelection){
                        ForEach(vetList, id: \.self) { vet in
                            Text(vet.name ?? NSLocalizedString("UnknownVet", comment: ""))
                                .tag(vet as Vet)
                        }
                    }
                    
                    DatePicker(NSLocalizedString("CheckupTime", comment: ""), selection: $nextCheckup, displayedComponents: [.date])
                    
                    Toggle(isOn: $getsMedication){
                        Text(NSLocalizedString("MedNeed", comment: ""))
                    }
                    
                    if getsMedication {
                        Picker(NSLocalizedString("Meds", comment: ""), selection: $medSelection){
                            ForEach(medList, id: \.self) { med in
                                Text(med.name ?? NSLocalizedString("UnknownMeds", comment: ""))
                                    .tag(med as Medication)
                            }
                        }
                    }
                    
                    HStack {
                        Text(NSLocalizedString("SoundRecorder", comment: ""))
                        Spacer()
                            .frame(width: 70)
                        
                        VStack(alignment: .trailing) {
                            Button {
                                audioModel.startRecording()
                            } label: {
                                HStack {
                                    Image(systemName: "recordingtape.circle")
                                        .foregroundColor(Color.black)
                                    Text(NSLocalizedString("StartRecording", comment: ""))
                                }
                            }
                            
                            .controlSize(.regular)
                            .foregroundColor(Color.black)
                            
                            Button {
                                audioModel.stopRecording()
                            } label: {
                                HStack {
                                    Image(systemName: "stop.circle")
                                    Text(NSLocalizedString("StopRecording", comment: ""))
                                }
                            }
                            .controlSize(.regular)
                            .disabled(!audioModel.isRecording)
                        }
                    }
                    
                    
                }
                .scrollContentBackground(.hidden)
                
                
                Button(NSLocalizedString("Add", comment: "")){
                    
                    guard let imageData = animalImageData else {
                        print("No image data available.")
                        return
                    }
                    
                    guard let petSoundURL = audioModel.soundFileURL else {
                        print("No audio file URL available.")
                        return
                    }
                    
                    petViewModel.addPet(
                        petName: petName,
                        petKind: petSelection,
                        petAge: petAge,
                        petBreed: petBreed,
                        vet: vetSelection,
                        nextCheckup: nextCheckup,
                        getsMedication: getsMedication,
                        medication: medSelection,
                        animalImage: imageData,
                        animalSound: petSoundURL.absoluteString
                    )
                }
                .padding()
                .font(.system(size: 18, weight: .bold))
                .frame(width: UIScreen.main.bounds.width - 40)
                .foregroundColor(Color("BackgroundColor"))
                .background(Color("LinkColor"))
                .clipShape(Capsule())
                .padding(.horizontal)
                
            }
            .padding(.top, 5)
            .onChange(of: selectedPhoto) { newItem in
                Task {
                    guard let imageData = try? await
                            newItem?.loadTransferable(type: Data.self) else { return }
                    animalImageData = imageData
                    imageView = Image(uiImage: UIImage(data: imageData)!)
                }
                
            }
        }
    }
    
}

struct AddPetFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetFormView()
    }
}
