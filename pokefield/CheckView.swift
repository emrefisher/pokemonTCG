//
//  CheckView.swift
//  Created by Emre Fisher on 2/25/21.
//

import SwiftUI

struct CheckView: View {
    @State var isChecked:Bool = false
    @Binding var selectedTypes : [String]
    var title:String
    func toggle(){
        isChecked = !isChecked
        if (isChecked) {
        selectedTypes.append(title)
        }
        else {
            selectedTypes = selectedTypes.filter{$0 != title}
        }
    }
    var body: some View {
        HStack{
            Button(action: {
                if selectedTypes.count < 2 || isChecked == true {
                    toggle()
                }
            }) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
            }
            Text(title)
        }
    }
}

