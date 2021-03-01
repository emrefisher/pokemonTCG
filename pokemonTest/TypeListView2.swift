//
//  TypeListView.swift
//  pokemonTest
//
//  Created by Emre Fisher on 2/25/21.
//

import Foundation
import SwiftUI

struct TypeListView2: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Button("Back") {
            isPresented.toggle()
        }
        List(checkListData2){ item in
            CheckView2(isChecked: item.isChecked, selectedStatus: $viewModel.playerOneData[viewModel.clickedCard].status, title: item.title)
        }
        .font(.title)
    }
}
