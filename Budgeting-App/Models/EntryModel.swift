//
//  EntryModel.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 21/11/23.
//

import Foundation
import SwiftData

@Model
class Entry {
    var amount : Int
    var date : Date
    var category : String
    
    init(amount: Int, date: Date = .now, category: String) {
        self.amount = amount
        self.date = date
        self.category = category
    }
    
}
