//
//  ContentView.swift
//  Shared
//
//  Created by CJS on 2021/8/1.
//

import SwiftUI

struct ExampleItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var destination: AnyView

    init<V>(title: String, destination: V) where V: View {
        self.title = title
        self.destination = AnyView(destination)
    }
}

struct ContentView: View {
    
    var examples: [ExampleItem] = [
        ExampleItem(title: "LabelExample", destination: LabelExample()),
        ExampleItem(title: "PreferenceExample", destination: PreferenceExample()),
        ExampleItem(title: "ScrollViewExample", destination: ScrollViewExample()),
        ExampleItem(title: "ListExample", destination: ListExample())
    ]
    
    var body: some View {
        NavigationView {
            List(examples) { item in
                NavigationLink(
                    destination: item.destination,
                    label: {
                        Text(item.title)
                    })
                    .navigationTitle(item.title)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("Learn-SwiftUI")
            .navigationBarTitle("Learn-SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
