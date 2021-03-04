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
    @State var showingTypes = false
    @State var showingStatus = false
//    @Binding var data: [IndividualCard]
    @ObservedObject var viewModel: ViewModel
    
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
                ForEach(viewModel.playerTwoData) { card in
                    
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.white.opacity(0.6))
                                .frame(width: UIScreen.main.bounds.width/8, height: UIScreen.main.bounds.height/2)
                                .border(((card.position == 0) ? Color.red : Color.green), width: 5)
                            
                            //CARD TYPE
                            if card.types.count == 0 {
                                VStack {
                                Button(action: {
                                    viewModel.clickedCard = card.position
                                    showingTypes.toggle()
                                }) {
                                    Text("Add Types").foregroundColor(.black)
                                }
                                    Spacer()
                                }.padding(.top, 15)
                                .sheet(isPresented: $showingTypes) {
                                    TypeListView(isPresented: $showingTypes, viewModel: viewModel, player: 2)
                                }
                            }
                            else {
                                
                                VStack(spacing: 1) {
                                    ForEach(viewModel.playerTwoData[card.position].types, id: \.self) {type in
                                        Image(type)
                                            .resizable()
                                           // .scaledToFit()
                                            .frame(  width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.height/13)
                                    }

                                    Spacer()
                                }.padding(.top, 5)

                            }
                            //CARD STATUS
                            if card.status == "None" {
                            VStack {
                            Button("Status") {
                                viewModel.clickedCard = card.position
                                showingStatus.toggle()
                            }
                            .sheet(isPresented: $showingStatus) {
                                TypeListView2(isPresented: $showingStatus, viewModel: viewModel, player: 2)
                            }
                            
                                Text("\(viewModel.playerTwoData[card.position].status)")
                            }
                            
                            
                        }
                            else {
                                VStack(spacing: 1) {
                                    Spacer()
                                    HStack(spacing: 1) {
                                        Spacer()
                                Image(card.status)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75, height: 75)
                                    }
                                }.offset(x: 5, y: 10)
                            }
                        }
                        //SWITCHING MECHANIC
                        if isSwitching {
                            Button("Tag-In") {
                                withAnimation {
                                    viewModel.playerTwoData[0].position = card.position
                                    viewModel.playerTwoData[card.position].position = 0
                                    viewModel.playerTwoData.sort {
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
