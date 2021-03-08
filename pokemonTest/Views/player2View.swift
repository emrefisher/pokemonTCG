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
                            
                            //CARD DAMAGE
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Button(action: {
                                        viewModel.playerTwoData[card.position].damageTaken -= 10
                                    }) {
                                        Text("-   ").background(Circle()
                                            .trim(from: 0.25, to: 0.75)
                                            .fill(Color.red)
                                            .frame(width: 40, height: 40))
                                            .rotationEffect(.degrees(180))
                                            .offset(x: -5)
                                    }
                                    Spacer()
                                    Text("\(viewModel.playerTwoData[card.position].damageTaken)")
                                    Spacer()
                                    Button(action: {
                                        viewModel.playerTwoData[card.position].damageTaken += 10
                                    }) {
                                        Text("+  ").background(Circle()
                                            .trim(from: 0.25, to: 0.75)
                                            .fill(Color.green)
                                            .frame(width: 40, height: 40)
                                                                .offset(x: 4)
                                            )
                                    }
                                }
                                Button("Clear Card") {
                                    viewModel.playerTwoData[card.position].status = "None"
                                    viewModel.playerTwoData[card.position].damageTaken = 0
                                    viewModel.playerTwoData[card.position].types = [String]()
                                }
                            }.padding(.horizontal, 5)
                            
                            
                                
                
                            //CARD STATUS
                            //CARD STATUS
                            ZStack {
                                if card.status == "None" {
                                    VStack {
                                        Spacer()
                                        Button("Add Status") {
                                            viewModel.clickedCard = card.position
                                            showingStatus.toggle()
                                        }
                                        
                                    }.padding(.bottom, 7.5)
                                }
                                else {
                                    VStack(spacing: 1) {
                                        Spacer()
                                        HStack(spacing: 1) {
                                            Spacer()
                                            Button(action: {
                                                viewModel.clickedCard = card.position
                                                showingStatus.toggle()
                                            }) {
                                                Image(card.status)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 75, height: 75)
                                            }
                                            
                                        }
                                    }.offset(x: 5, y: 10)
                                }
                            }.sheet(isPresented: $showingStatus) {
                                TypeListView2(isPresented: $showingStatus, viewModel: viewModel, player: 2)
                            }
                            /*if card.status == "None" {
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
                                        
                                        Button(action:  {
                                            viewModel.clickedCard = card.position
                                            showingStatus.toggle()
                                        }) {
                                            Image(card.status)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 75, height: 75)
                                        }
                                        .sheet(isPresented: $showingStatus) {
                                            TypeListView2(isPresented: $showingStatus, viewModel: viewModel, player: 2)
                                        }
                                        
                                        
                               
                                    }
                                }.offset(x: 5, y: 10)
                            }*/
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
