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
    
    var body: some View {
               
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text(NSLocalizedString("AddNew", comment: ""))
                    .font(.largeTitle.bold()).foregroundColor(Color("TitleFontColor"))
                
                TextField(NSLocalizedString("PetName", comment: ""), text: $petName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
               
                Button(NSLocalizedString("Add", comment: "")){
                    addPet()
                }
                .padding()
                .font(.system(size: 18, weight: .bold)).foregroundColor(Color("BackgroundColor"))
                .frame(maxWidth: .infinity)
                .background(Color("LinkColor"))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 30)
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
