//
//  EntriesListView.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 21/11/23.
//

import SwiftUI
import SwiftData

struct EntriesListView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = 0
    
    //Implement Dynamic Sort Descriptor
    @Query var entries : [Entry]
    
    private var groupedByDayEntries: [Date: [Entry]] {
        groupEntriesByDay(entries: entries)
    }

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
        VStack{
            
            Spacer()
            
            
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
            
            
            List {
                ForEach(entries) { entry in
                    
                    VStack(alignment: .leading){
                        HStack{
                            
                            ZStack{
                                
                                let rectangleColor = categoryColor(entry: entry)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(rectangleColor)
                                
                                Text(categoryEmoji(entry: entry))
                            }
                                
                            VStack(alignment: .leading){
                                Text(entry.category)
                                    .bold()
                                Text(entry.date.formatted(.dateTime.hour().minute()))
                                    .font(.footnote)
                                    .foregroundStyle(Color.gray)
                            }
                            
                            
                            Spacer()
                            
                            Text(String(entry.amount) + "$")
                                .font(.system(size: 20))

                        }
                    }
                }.onDelete(perform: deleteEntry)
            }
            
        }
    }
    
    //Delete Entry Function
    func deleteEntry(_ indexSet: IndexSet){
        for index in indexSet {
            let entry = entries[index]
            modelContext.delete(entry)
        }
    }
    
    func groupEntriesByDay(entries: [Entry]) -> [Date: [Entry]] {
        var groupedByDayEntries = [Date: [Entry]]()

        let calendar = Calendar.current

        for entry in entries {
            // Extract the start of the day from the entry date
            let dateStartOfDay = calendar.startOfDay(for: entry.date)
            
            // Append the entry to the array for this day, or create a new array if it doesn't exist
            if var entriesForDay = groupedByDayEntries[dateStartOfDay] {
                entriesForDay.append(entry)
                groupedByDayEntries[dateStartOfDay] = entriesForDay
            } else {
                groupedByDayEntries[dateStartOfDay] = [entry]
            }
        }

        return groupedByDayEntries
    }

    
    //Function that checks the category color.
    func categoryColor(entry: Entry) -> Color {
        let modifiedCategory = String(entry.category)

        if modifiedCategory == "Transport" {
            return Color.orange
        } else if modifiedCategory == "Groceries" { // Example for another category
            return Color.green
        } else if modifiedCategory == "Rent" { // Another example
            return Color.blue
        } else if modifiedCategory == "Other" {
            return Color.purple
        } else {
            return Color.gray
        }
    }
    
    //Function that checks the category emoji.
    func categoryEmoji(entry: Entry) -> String {
        let modifiedCategory = String(entry.category)

        if modifiedCategory == "Transport" {
            return "🚌"
        } else if modifiedCategory == "Groceries" {
            return "🛒"
        } else if modifiedCategory == "Rent" {
            return "🏠"
        } else if modifiedCategory == "Other" {
            return "📝"
        } else {
            return "✏️"
        }
    }
}

#Preview {
    EntriesListView()
}
