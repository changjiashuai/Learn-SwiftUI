//
//  ListExample.swift
//  Learn-SwiftUI
//
//  Created by CJS on 2021/8/14.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id: UUID = UUID()
    var task: String
    var imageName: String
}

struct ListExample: View {
    
    @State private var todos = [
        TodoItem(task: "吃饭", imageName: "pencil.circle"),
        TodoItem(task: "睡觉", imageName: "moon"),
        TodoItem(task: "打豆豆", imageName: "square.and.pencil"),
    ]
    
    @State private var showAlert = false
    @State private var showAlertItem: TodoItem? = nil
    
    /// ScrollView nested List error; List nested List error
    var body: some View {
//        ScrollView {
            List {
                Section(header: Text("静态列表")) {
//                    List {
                        Text("AAA")
                        Text("BBB")
                        Text("CCC")
//                    }
                }

                Section(header: Text("动态列表")) {
                    ForEach(todos) { item in
                        HStack {
                            Image(systemName: item.imageName)
                            Text(item.task)
                        }
                        .onTapGesture {
                            debugPrint("item=\(item)")
                            self.showAlertItem = item
                            AlertManager.shared.show(title: item.task, message: "item=\(item.task)", defaultTitle: "Ok", defaultAction: {_ in }, cancelTitle: "Cancel", cancelAction: {_ in }, destructiveTitle: "Destructive", destructiveAction: {_ in })
                        }
                        ///only outter alert can work !!!
                        .alert(item: $showAlertItem) { item in
                            Alert(title: Text("item=\(item.task)"), primaryButton: .destructive(Text("Destructive"), action: {
                                //
                            }), secondaryButton: .default(Text("Default"), action: {
                                //
                            }))
                        }
                    }
                    .onDelete(perform: deleteItem(at:))
                    .onMove(perform: moveItem(from:to:))
                    }
                /// overrides inner alert !!!
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("show alert"))
                })
            
                Section(header: Text("混合列表")) {
//                    List {
                        ForEach(todos) { item in
                            HStack {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                        Text("static value item")
//                    }
                }
                Button(action: {
                    self.showAlert = true
                }, label: {
                    Text("Button")
                })
            }
            .toolbar(content: {
                EditButton()
            })
            .navigationTitle("待办清单")
            .listStyle(GroupedListStyle())
//        }
    }
    
    private func moveItem(from source: IndexSet, to destination: Int) {
        todos.move(fromOffsets: source, toOffset: destination)
    }
    
    private func deleteItem(at offsets: IndexSet){
        todos.remove(atOffsets: offsets)
    }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}
