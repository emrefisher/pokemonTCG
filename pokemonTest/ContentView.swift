//
//  ContentView.swift
//  pokemonTest
//
//  Created by Emre Fisher on 2/25/21.
//

import SwiftUI

struct GameView: View {
    
    @State var showingPlayerOne = 0
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
        VStack {
            HStack {
                Spacer()
                Picker("", selection: $showingPlayerOne) {
                    Text("Player One").tag(0)
                    Text("Player Two").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .frame(width: UIScreen.main.bounds.width / 4)
                Spacer()
                Button("New Game", action: {
                    for card in 0..<viewModel.playerOneData.count {
                        viewModel.playerOneData[card].status = "None"
                        viewModel.playerOneData[card].damageTaken = 0
                    }
                    for card in 0..<viewModel.playerTwoData.count {
                        viewModel.playerTwoData[card].status = "None"
                        viewModel.playerTwoData[card].damageTaken = 0
                    }
                })
            }
            Spacer()
            if showingPlayerOne == 0 {
                PlayerOneView(viewModel: viewModel)
            }
            else {
                PlayerTwoView(data: $viewModel.playerTwoData)
            }
            Spacer()
        }.padding(.top, UIScreen.main.bounds.height/15)
        }

    }
}

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
                                    Text("Add Types").foregroundColor(.black)
                                }
                                    Spacer()
                                }.padding(.top, 15)
                                .sheet(isPresented: $showingTypes) {
                                    TypeListView(isPresented: $showingTypes, viewModel: viewModel)
                                }
                            }
                            else {
                                
                                VStack {
                                    ForEach(viewModel.playerOneData[card.position].types, id: \.self) {type in
                                        Image(type)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.main.bounds.width/10)
                                    }

                                    Spacer()
                                }.padding(.top, 15)

                            }
                            //CARD STATUS
                            VStack {
                            Button("Status") {
                                viewModel.clickedCard = card.position
                                showingStatus.toggle()
                            }
                            .sheet(isPresented: $showingStatus) {
                                TypeListView2(isPresented: $showingStatus, viewModel: viewModel)
                            }
                            
                                Text("\(viewModel.playerOneData[card.position].status)")
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

struct IndividualCard: Identifiable {
    var id: String
    var position: Int
    var status: String
    var damageTaken: Int
    var types: [String]
}


/*List(checkListData){ item in
CheckView(isChecked: item.isChecked, title: item.title)
}
.font(.title)*/

class ViewModel: ObservableObject {
    
    @Published var playerOneData = [IndividualCard(id: "Card 0", position: 0, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 1", position: 1, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 2", position: 2, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 3", position: 3, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 4", position: 4, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 5", position: 5, status: "None", damageTaken: 0, types: [String]())]
    
    @Published var playerTwoData = [IndividualCard(id: "Card 0", position: 0, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 1", position: 1, status: "Burned", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 2", position: 2, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 3", position: 3, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 4", position: 4, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 5", position: 5, status: "Asleep", damageTaken: 0, types: [String]())]
    
    @Published var clickedCard = -1
    
}
