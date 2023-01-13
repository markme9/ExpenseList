//
//  TextView.swift
//  ExpenseList
//
//  Created by mark me on 12/19/22.
//

import SwiftUI

struct TextView: View {
    
    @State var name: String = ""
    @State var type: String = ""
    @State var amount: Int = 0
    
    // Picker
    let types: [String] = ["Personal", "Food", "Business", "Shopping", "Madisons", "Education", "Maintenance"]
    
    // Call back function
    var data: (Model) -> ()
    
    // Dismiss View
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Items")) {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.numberPad)
                    
                    Button {
                        
                        dismiss()
                        
                        data(.init(name: name, type: type, amount: amount, date: date))
                        
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                    
                }
            }
            .navigationTitle(Text("Add new expense"))
            .toolbar {
                Button {
                    withAnimation {
                        dismiss()
                    }
                    
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .frame(width: 30, height: 30)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }

            }
        }
    }
    var date: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let newDate = dateFormatter.string(from: date)
        
        return newDate
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(data: {_ in})
    }
}
