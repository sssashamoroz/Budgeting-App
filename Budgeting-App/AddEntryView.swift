//
//  AddEntryView.swift
//  Budgeting-App
//
//  Created by Aleksandr Morozov on 21/11/23.
//

import SwiftUI

struct AddEntryView: View {
    
    @State private var amount: String = ""
    @State private var entryTypeSegmentation = 0
    @State private var selectedCategory: String = "Category"
    
    //Buttons Control
    @State private var entryButtonPressed = false
    @State private var dotButtonPressed = false
    
    //Date Picker
    @State private var date = Date()
    
    //Category Picker
    @State private var showPicker = false
    @State private var categoryButtonFrame: CGRect = .zero
        
    private var categoryColor: Color {
        switch selectedCategory {
        case "Category":
            return Color.gray
        case "🏠 Rent":
            return Color.green
        case "🛒 Groceries":
            return Color.blue
        case "🚌 Transport":
            return Color.orange
        case "📝 Other":
            return Color.purple
        default:
            return Color.pink.opacity(0.2) // Default color
        }
    }

    
    var body: some View {
        ZStack{
            if showPicker {
                CategoryPickerView(selectedCategory: $selectedCategory, showPicker: $showPicker)
                    .position(x: categoryButtonFrame.midX+46, y: categoryButtonFrame.maxY - 190)

            }
            
            VStack{
                
                //Income or Expense Picker
                Picker("Type of Entry", selection: $entryTypeSegmentation){
                    Text("Expense")
                        .bold()
                        .tag(0)
                    Text("Income")
                        .bold()
                        .tag(1)
                }
                .frame(width: 200)
                .pickerStyle(.segmented)
                .padding(.horizontal, 4)
                .padding(.top, 4)
                .padding(.bottom, 5)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                        .background(Color.black)
                    
                )
                
                Spacer()

                //Money Display
                HStack{
                    Spacer()
            

                    Text("$")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                        .bold()
                        
                    
                    Text(amount.isEmpty ? "0" : amount.prefix(7))
                        .font(.system(size: 60))
                        .bold()
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 30)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                        .overlay(
                            Image(systemName: "delete.left.fill")
                                .opacity(0.5)
                                .font(.body)
                        )
                        .onTapGesture {
                            amount = String(amount.dropLast())
                        }
                        .opacity(amount.isEmpty ? 0 : 1)
                   
                }.padding(10)
                
                Spacer()
                
                //Date and Category
                HStack{
                    //Date
                    HStack{
                        Image(systemName: "calendar")
                            .padding(.trailing, 1)
                            .padding(.leading, 6)
                            .foregroundColor(.gray)
                        
                        DatePicker(
                            "Entry Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                    }
                    .padding(.horizontal, 4)
                    .padding(.top, 4)
                    .padding(.bottom, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                            .background(Color.black)
                    )
                    
                    //Category
                    HStack{
                        Text("\(selectedCategory)")
                            .bold()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 43)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(categoryColor.opacity(0.1))
                            .stroke(categoryColor.opacity(0.5), lineWidth: 1.5)
                    )
                    .overlay(GeometryReader { proxy in
                        Color.clear.preference(key: AnchorPreferenceKey.self, value: proxy.frame(in: .global))
                    })
                    .onTapGesture {
                        showPicker.toggle()
                    }
                    .onPreferenceChange(AnchorPreferenceKey.self) { preferences in
                        // Store the position in a state variable
                        self.categoryButtonFrame = preferences
                    }
                }.padding(.horizontal, 8)
                
                
                //Custom Keyboard
                VStack{
                    
                    //Line 1
                    HStack{
                        Button("1") {
                            amount += "1"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        Button("2") {
                            amount += "2"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        Button("3") {
                            amount += "3"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                    }
                    
                    //Line 2
                    HStack{
                        Button("4") {
                            amount += "4"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        Button("5") {
                            amount += "5"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        Button("6") {
                            amount += "6"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                    }
                    
                    //Line 3
                    HStack{
                        Button("7") {
                            amount += "7"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        Button("8") {
                            amount += "8"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        Button("9") {
                            amount += "9"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                    }
                    
                    //Line 4
                    HStack{
                        Button(".") {
                            print("Button pressed!")
                        }
                        .font(.title)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width/3.4 )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(dotButtonPressed ? 0.2 : 0.4))
                        )
                        .scaleEffect(dotButtonPressed ? 0.9 : 1.0) // Smaller when pressed
                        .onLongPressGesture(minimumDuration: 0.1, pressing: { isCurrentlyPressed in
                            withAnimation {
                                self.dotButtonPressed = isCurrentlyPressed
                            }
                        }, perform: {})
                        .padding(.top, 5)
                        .padding(.horizontal, 2.5)
                        
                        Button("0") {
                            amount += "0"
                        }
                        .buttonStyle(PressableButtonStyle())
                        
                        
                        //Send Entry Button
                        Button(action: {
                            print("Button pressed!")
                        }) {
                            Image(systemName: "checkmark.square.fill")
                                .font(.title) // Adjust the size of the system image
                                .colorInvert()
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 3.4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(entryButtonPressed ? 0.5 : 1))
                        )
                        .scaleEffect(entryButtonPressed ? 0.9 : 1.0) // Smaller when pressed
                        .onLongPressGesture(minimumDuration: 0.1, pressing: { isCurrentlyPressed in
                            withAnimation {
                                self.entryButtonPressed = isCurrentlyPressed
                            }
                        }, perform: {})
                        .padding(.top, 5)
                        .padding(.horizontal, 2.5)
                    }
                }
            }
            .opacity(showPicker ? 0.4 : 1)
            .animation(.default, value: showPicker)
        }
       
        
    }
}

//OverlayCategoryView
struct CategoryPickerView: View {
    @Binding var selectedCategory: String
    @Binding var showPicker: Bool

    var body: some View {
        ZStack{
            
            Color.black.opacity(0.0000001) //LOOOOL
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        selectCategory("Category") // Or any default value you prefer
                    }
                }
            
            VStack(alignment: .trailing) {
                Button("🏠 Rent") {
                    selectCategory("🏠 Rent")
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                )
                
                Button("🛒 Groceries") {
                    selectCategory("🛒 Groceries")
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                )
                
                Button("🚌 Transport") {
                    selectCategory("🚌 Transport")
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                )
                
                Button("📝 Other") {
                    selectCategory("🚌 Transport")
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                )
            }
        }
    }

    private func selectCategory(_ category: String) {
        selectedCategory = category
        showPicker = false
    }
}


//Button Style
struct PressableButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .padding()
            .frame(width: UIScreen.main.bounds.width/3.4)
            .background(
                RoundedRectangle(cornerRadius: 10,  style: .continuous)
                    .fill(Color.gray.opacity(configuration.isPressed ? 0.2 : 0.4))
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut, value: configuration.isPressed)
            .padding(.top, 5)
            .padding(.horizontal, 2.5)
    }
}

//Test
struct AnchorPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}


#Preview {
    AddEntryView()
}
