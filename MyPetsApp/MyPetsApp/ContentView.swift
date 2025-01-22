//
//  ContentView.swift
//  MyPetsApp
//
//  Created by user on 20.01.25.
//

import SwiftUI

struct ContentView: View {
    @State private var scale = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack(alignment: .trailing, spacing: 20){
                    
                    Text(NSLocalizedString("MyPets", comment: ""))
                        .font(.largeTitle.bold())
                    
                    HStack {
                        
                        NavigationLink(destination: MainScreenView()){
                            
                            Label (NSLocalizedString("Start", comment: ""), systemImage: "chevron.forward.2")
                                .font(.system(size: 18, weight: .bold)).foregroundColor(.gray)
                                .padding()
                                .scaleEffect(scale)
                                .animation(.linear(duration: 1), value: scale)
                        }
                    }
                }
                
                .offset(x: 0, y: -200)
                .padding(30)
                
            }
            .ignoresSafeArea()
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
