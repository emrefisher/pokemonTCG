//
//  TypeListView.swift
//  Created by Emre Fisher on 2/25/21.
//

import Foundation
import SwiftUI

struct TypeListView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: ViewModel
    var player: Int
    
   // @Binding var selectedTypes: [String]
    var body: some View {
        Button("Back") {
            isPresented.toggle()
        }
        List(checkListData){ item in
            CheckView(isChecked: item.isChecked, selectedTypes: ((player == 1) ? $viewModel.playerOneData[viewModel.clickedCard].types : $viewModel.playerTwoData[viewModel.clickedCard].types), title: item.title)
        }
        .font(.title)
    }
}
