//
//  checkListItem.swift
//  pokemonTest
//
//  Created by Emre Fisher on 2/25/21.
//

import Foundation
import SwiftUI

struct CheckListItem:Identifiable{
    var id:Int
    var isChecked: Bool = false
    var title: String
}
