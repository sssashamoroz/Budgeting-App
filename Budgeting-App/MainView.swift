//
//  MainView.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 21/11/23.
//

import SwiftUI

struct MainView: View {
    

    var body: some View {
        
        TabView{
            
            EntriesListView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
                .tag(1)
            
            InsightsView()
                .tabItem {
                    Label("Insgihts", systemImage: "chart.bar.xaxis.ascending")
                }
                .tag(2)
            
            AddEntryView()
                .tabItem {
                    Label("Add", systemImage: "plus.rectangle.fill")
                }
                .tag(3)
     
            
            BudgetsView()
                .tabItem {
                    Label("Budgets", systemImage: "creditcard.fill")
                }
                .tag(4)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(4)
            
        }
    }
}

#Preview {
    MainView()
}
