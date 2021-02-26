//
//  TypeListView.swift
//  pokemonTest
//
//  Created by Emre Fisher on 2/25/21.
//

import Foundation
import SwiftUI

struct TypeListView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTypes: [String]
   // @Binding var selectedTypes: [String]
    var body: some View {
        Button("Back") {
            isPresented.toggle()
        }
        List(checkListData){ item in
            CheckView(isChecked: item.isChecked, selectedTypes: $selectedTypes, title: item.title)
        }
        .font(.title)
    }
}
