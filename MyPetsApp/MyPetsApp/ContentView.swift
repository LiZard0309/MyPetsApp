//
//  ContentView.swift
//  MyPetsApp
//
//  Created by user on 20.01.25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack{
            Text("My Pets")
                .font(.largeTitle.bold())
                
            Spacer()
            
            
            Button("Add new pet"){
                addNewPet()
            }
        }
    }
    
    func addNewPet() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
