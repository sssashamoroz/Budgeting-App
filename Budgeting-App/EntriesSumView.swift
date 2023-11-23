//
//  EntriesSumView.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 23/11/23.
//

import SwiftUI
import SwiftData

struct EntriesSumView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var entries : [Entry]

    @State private var totalSum : Float = 0
    
    private var calculatedSum: Float {
            var total: Float = 0.0
            for entry in entries {
                total += entry.amount
            }
            return total
        }
    
    var body: some View {
        
        
        HStack{
            Text("$")
                .font(.system(size: 40))
                .foregroundColor(.gray)
                .bold()
                .accessibilityHidden(true)
            
            Text(String(format: "%.2f", calculatedSum).prefix(7))
                .contentTransition(.numericText())
                .font(.system(size: 60))
                .accessibilityLabel(String(format: "%.2f", calculatedSum).prefix(7)+" dollars.")

        }
        
        
        
    }
    
    init(sort: SortDescriptor<Entry>, range : String){
        
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        
        var startDate: Date
        var endDate = now
        
        switch range {
        case "today":
            startDate = startOfDay
            endDate = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        case "this week":
            startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
            endDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
        case "this month":
            startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        case "this year":
            startDate = calendar.date(from: calendar.dateComponents([.year], from: now))!
            endDate = calendar.date(byAdding: .year, value: 1, to: startDate)!
        default:
            startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        }
        
        _entries = Query(filter: #Predicate {
            $0.date >= startDate && $0.date < endDate
        },
                         sort: [sort])
    }
    
    
}

#Preview {
    EntriesSumView(sort: SortDescriptor(\Entry.date), range : "today")
}
