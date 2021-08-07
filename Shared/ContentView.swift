//
//  ContentView.swift
//  Shared
//
//  Created by CJS on 2021/8/1.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: LabelExample(),
                    label: {
                        Text("LabelExample")
                    })
                NavigationLink(
                    destination: PreferenceExample(),
                    label: {
                        Text("PreferenceExample")
                    })
            }
        }.navigationTitle("Learn-SwiftUI")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
