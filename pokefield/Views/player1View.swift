//
//  player1View.swift
// 
//  Created by Emre Fisher on 3/3/21.
//

import Foundation
import SwiftUI

struct PlayerOneView: View {
    
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
                ForEach(viewModel.playerOneData) { card in
                    
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
                                    Text("Add Types").foregroundColor(.blue)
                                }
                                    Spacer()
                                }.padding(.top, 15)
                                .sheet(isPresented: $showingTypes) {
                                    TypeListView(isPresented: $showingTypes, viewModel: viewModel, player: 1)
                                }
                            }
                            else {
                                
                                VStack(spacing: 1) {
                                    ForEach(viewModel.playerOneData[card.position].types, id: \.self) {type in
                                        Image(type)
                                            .resizable()
                                           // .scaledToFit()
                                            .frame(  width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.height/13)
                                    }

                                    Spacer()
                                }.padding(.top, 5)

                            }
                            
                            
                            VStack {
                                HStack(spacing: 0) {
                                    Button(action: {
                                        if viewModel.playerOneData[card.position].damageTaken != 0 {
                                            viewModel.playerOneData[card.position].damageTaken -= 10
                                        }
                                    }) {
                                        Text("-   ").background(Circle()
                                            .trim(from: 0.25, to: 0.75)
                                            .fill(Color.red)
                                            .frame(width: 40, height: 40))
                                            .rotationEffect(.degrees(180))
                                            .offset(x: -5)
                                    }
                                    Spacer()
                                    Text("\(viewModel.playerOneData[card.position].damageTaken)")
                                    Spacer()
                                    Button(action: {
                                        viewModel.playerOneData[card.position].damageTaken += 10
                                    }) {
                                        Text("+ ").background(Circle()
                                            .trim(from: 0.25, to: 0.75)
                                            .fill(Color.green)
                                            .frame(width: 40, height: 40)
                                                                .offset(x: 4)
                                            )
                                    }
                                }
                                
                                VStack {
                                Button(action: {
                                    viewModel.playerOneData[card.position].status = "None"
                                    viewModel.playerOneData[card.position].damageTaken = 0
                                    viewModel.playerOneData[card.position].types = [String]()
                                }) {
                                    Text("Clear Card")
                                        .font(.system(size: 12.5))
                                        .foregroundColor(Color.black)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .background(Capsule().fill(Color.white))
                                        .offset(y:5)
                                }
                                }
                            }.padding(.horizontal, 5)
                            .offset(y:10)
                            
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
                                TypeListView2(isPresented: $showingStatus, viewModel: viewModel, player: 1)
                            }
                        }
                        //SWITCHING MECHANIC
                        if isSwitching {
                            Button("Tag-In") {
                                withAnimation {
                                    viewModel.playerOneData[0].position = card.position
                                    viewModel.playerOneData[card.position].position = 0
                                    viewModel.playerOneData.sort {
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
