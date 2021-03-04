//
//  player2View.swift
//  pokemonTest
//
//  Created by Emre Fisher on 3/3/21.
//

import Foundation
import SwiftUI

struct PlayerTwoView: View {
    
    @State var isSwitching = false
    
    @Binding var data: [IndividualCard]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, content: {
                ForEach(data) { card in
                    
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: UIScreen.main.bounds.width/8, height: UIScreen.main.bounds.height/2)
                                .border(((card.position == 0) ? Color.red : Color.green), width: 5)
                            
                            Text(card.id).foregroundColor(Color.red)
                        }
                        if isSwitching {
                            Button("Tag-In") {
                                withAnimation {
                                    data[0].position = card.position
                                    data[card.position].position = 0
                                    data.sort {
                                        $0.position < $1.position
                                    }
                                }
                                
                            }.opacity((card.position == 0) ? 0 : 1)
                        }
                    }
                }
            })
            Button(action: {
                self.isSwitching.toggle()
            }) {
                Text("Change Card")
            }
        }
    }
}
