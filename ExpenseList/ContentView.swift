//
//  ContentView.swift
//  ExpenseList
//
//  Created by mark me on 12/19/22.
//

import SwiftUI

struct Model: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Int
    var date: String
}

class ViewModel: ObservableObject {
    @Published var data: [Model] = [] {
        didSet {
            fetchData()
        }
    }
    init() {
        saveData()
    }
    
    func fetchData() {
        if let save = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(save, forKey: "key")
        }
    }
    func saveData() {
        guard let saveit = UserDefaults.standard.data(forKey: "key") else { return }
        guard let encodeData = try? JSONDecoder().decode([Model].self, from: saveit) else { return }
        
        self.data = encodeData
    }
}

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.data) { item in
                    HStack(spacing: 15) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .fontWeight(.semibold)
                                
                            
                            Text(item.type)
                                .foregroundColor(Color(UIColor.gray))
                        }
                        Spacer()
                        VStack {
                            if item.amount < 50 {
                                Text("$\(item.amount)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.green)
                                
                                Text(item.date)
                                    .font(.caption)
                                    .foregroundColor(Color(UIColor.gray))
                            }
                            else if item.amount < 100 {
                                Text("$\(item.amount)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.yellow)
                                
                                Text(item.date)
                                    .font(.caption)
                                    .foregroundColor(Color(UIColor.gray))
                            }
                            else if item.amount > 100 {
                                Text("$\(item.amount)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.red)
                                
                                Text(item.date)
                                    .font(.caption)
                                    .foregroundColor(Color(UIColor.gray))
                            }
                        }
                    }
                }
                .onDelete { index in
                    vm.data.remove(atOffsets: index)
                }
            }
            .navigationTitle(Text("Expense List"))
            .navigationBarItems(trailing: Button(action: {
                
                isPresented.toggle()
                
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .frame(width: 30, height: 30)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
            }))
            .fullScreenCover(isPresented: $isPresented) {
                TextView { item in
                    vm.data.append(item)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
