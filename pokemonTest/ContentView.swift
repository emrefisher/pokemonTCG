//
//  ContentView.swift
//  pokemonTest
//
//  Created by Emre Fisher on 2/25/21.
//

import SwiftUI

struct GameView: View {
    
    @State var showingPlayerOne = 0
    
    @State var playerOneData = [IndividualCard(id: "Card 0", position: 0, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 1", position: 1, status: "Burned", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 2", position: 2, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 3", position: 3, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 4", position: 4, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 5", position: 5, status: "Asleep", damageTaken: 0, types: [String]())]
    
    @State var playerTwoData = [IndividualCard(id: "Card 0", position: 0, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 1", position: 1, status: "Burned", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 2", position: 2, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 3", position: 3, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 4", position: 4, status: "Asleep", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 5", position: 5, status: "Asleep", damageTaken: 0, types: [String]())]
    
    var body: some View {
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
                    for card in 0..<playerOneData.count {
                        playerOneData[card].status = "None"
                        playerOneData[card].damageTaken = 0
                    }
                    for card in 0..<playerTwoData.count {
                        playerTwoData[card].status = "None"
                        playerTwoData[card].damageTaken = 0
                    }
                })
            }
            Spacer()
            if showingPlayerOne == 0 {
                PlayerOneView(data: $playerOneData)
            }
            else {
                PlayerTwoView(data: $playerTwoData)
            }
            Spacer()
        }.padding(.top, UIScreen.main.bounds.height/15)
    }
}

struct PlayerOneView: View {
    
    @State var isSwitching = false
    @State  var showingTypes = false
    @Binding var data: [IndividualCard]
    @State var selectedTypes = [String]()
    
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
                            
                            
                            Button("Type") {
                                showingTypes.toggle()
                            }.sheet(isPresented: $showingTypes, onDismiss: {data[card.position].types = selectedTypes
                                selectedTypes = [String]()
                            }) {
                                TypeListView(isPresented: $showingTypes, selectedTypes: $selectedTypes)
                            }
                                Text("\(data[card.position].types.count)")
                            
                            
                            
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
