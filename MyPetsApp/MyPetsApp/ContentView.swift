//
//  ContentView.swift
//  MyPetsApp
//
//  Created by user on 20.01.25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var scale = 1.0
    
    var body: some View {
        NavigationView(){
            ZStack {
                
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(alignment: .trailing, spacing: 10){
                    
                    Text(NSLocalizedString("MyPets", comment: ""))
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.trailing)
                    
                    
                        
                        NavigationLink(destination: MainScreenView()){
                            
                            Label (NSLocalizedString("Start", comment: ""), systemImage: "chevron.forward.2")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.gray)
                                .padding()
                                
                        }
                        .scaleEffect(scale)
                        .animation(.linear(duration: 2), value: scale)
                    
                }
                
                .offset(x: 0, y: -200)
                .padding(.trailing, -80)
                
                
            }
            
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
