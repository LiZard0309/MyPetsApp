//
//  AddPetFormView.swift
//  MyPetsApp
//
//  Created by user on 22.01.25.
//

import SwiftUI

struct AddPetFormView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var petName: String = ""
    @State var petAge: Int = 0
    @State var petSelection: String = ""
    
    let petKinds = [NSLocalizedString("Cat", comment: ""), NSLocalizedString("Dog", comment: ""), NSLocalizedString("Bunny", comment: ""), NSLocalizedString("Bird", comment: ""), NSLocalizedString("GuineaPig", comment: ""), NSLocalizedString("Turtle", comment: ""), NSLocalizedString("Mouse", comment: "")]
    
    var body: some View {
        
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 20) {
                Text(NSLocalizedString("AddNew", comment: ""))
                    .font(.title2.bold())
                    .foregroundColor(Color("TitleFontColor"))
                    .padding(.horizontal)
                
                VStack (spacing: 20) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(NSLocalizedString("PetNameLabel", comment: "Pet Name"))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("TitleFontColor"))
                        TextField(NSLocalizedString("PetName", comment: ""), text: $petName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    HStack (spacing: 15){
                        TextField(NSLocalizedString("PetAge", comment: ""), value: $petAge, format: .number)
                            .padding()
                            
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                            .frame(maxWidth: UIScreen.main.bounds.width / 5)
                        
                        Picker(NSLocalizedString("PetKind", comment: ""), selection: $petSelection){
                            ForEach(petKinds, id: \.self) { kind in
                                Text(kind)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                        .frame(maxWidth: UIScreen.main.bounds.width * 4 / 5)
                    }
                    
                    Button(action: {
                        addPet()
                    }) {
                        Text(NSLocalizedString("Add", comment: ""))
                            .padding()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("BackgroundColor"))
                            .frame(maxWidth: .infinity)
                            .background(Color("LinkColor"))
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                        
                    }
                    
                    
                }
                .padding()
                .background(Color("FormBackgroundColor")) // Slightly lighter color for form background
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
                
            }
        }
    }
    
    func addPet(){
        let pet = Pet(context: managedObjectContext)
    }
}

struct AddPetFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetFormView()
    }
}
