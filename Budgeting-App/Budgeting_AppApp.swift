//
//  Budgeting_AppApp.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 21/11/23.
//

import SwiftUI
import SwiftData

@main
struct Budgeting_AppApp: App {
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .preferredColorScheme(.dark)
            
        }.modelContainer(for: Entry.self)
    }
}
