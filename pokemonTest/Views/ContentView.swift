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
                PlayerTwoView(viewModel: viewModel)
            }
            Spacer()
        }.padding(.top, UIScreen.main.bounds.height/15)
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
    
    @Published var playerTwoData = [IndividualCard(id: "Card 0", position: 0, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 1", position: 1, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 2", position: 2, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 3", position: 3, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 4", position: 4, status: "None", damageTaken: 0, types: [String]()), IndividualCard(id: "Card 5", position: 5, status: "None", damageTaken: 0, types: [String]())]
    
    @Published var clickedCard = -1
    
}
