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
    
    var id = UUID()
    var amount : Float
    var date : Date
    var category : String
    var type = ""
    
    init(amount: Float, date : Date, category: String, type : String) {
        
        self.amount = amount
        self.date = date
        self.category = category
        self.type = type
    }
    
}
