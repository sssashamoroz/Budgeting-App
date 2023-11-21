//
//  EntriesListView.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 21/11/23.
//

import SwiftUI

struct EntriesListView: View {
    
    @State private var sortOrder = 0
    
    //Implement Dynamic Sort Descriptor
    
    
    //Dynamic menu text
    private var menuTitle: String {
            switch sortOrder {
                case 1: return "today"
                case 2: return "this week"
                case 3: return "this month"
                case 4: return "this year"
                default: return "this month"
            }
        }
    
    
    
    var body: some View {
        
        //Main Money Display
        VStack(spacing: 2){
            HStack{
                Text("Net total")
                    .bold()
                
                //Sort the results accodring to the order.
                Menu(menuTitle){
                    Picker("Sort", selection: $sortOrder){
                        Text("today")
                            .tag(1)
                        
                        Text("this week")
                            .tag(2)
                        
                        Text("this month")
                            .tag(3)
                        
                        Text("this year")
                            .tag(4)
                    }
                }
                .bold()
                .padding(.horizontal, 10)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray.opacity(0.7), lineWidth: 2)
                )
            }
            
            HStack{
                Text("$")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                    .bold()
                
                Text("0.00")
                    .font(.system(size: 60))
                    .bold()
            }
        }
    }
}

#Preview {
    EntriesListView()
}
