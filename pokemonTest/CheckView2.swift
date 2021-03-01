//
//  CheckView.swift
//  pokemonTest
//
//  Created by Emre Fisher on 2/25/21.
//

import SwiftUI

struct CheckView2: View {
    @State var isChecked:Bool = false
    @Binding var selectedStatus : String
    var title:String
    func toggle(){
        isChecked = !isChecked
        if (isChecked) {
            selectedStatus = title
        }
    }
    var body: some View {
        HStack{
            Button(action: toggle) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
            }
            Text(title)
        }
    }
}

