//
//  ScrollViewExample.swift
//  Learn-SwiftUI
//
//  Created by CJS on 2021/8/7.
//

import SwiftUI

struct ScrollViewExample: View {
    var body: some View {
//        ScrollView {
//            Text("A")
//                .background(GeometryReader { proxy in
//                    Color.clear
//                        .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .named("frameLayer")).minY) // In order to get the GeometryProxy frame according to our ScrollView's frame layer.
//                })
//            Text("B")
//            Text("C")
//        }
//        .coordinateSpace(name: "frameLayer") // the new coordinate space
        
        ScrollViewOffset { offset in
            print("New ScrollView offset: \(offset)")
        } content: {
            Text("A")
            Text("B")
            Text("C")
        }
    }
}

struct ScrollViewOffset<Content: View>: View {
    let onOffsetChange: (CGFloat) -> Void
    let content: () -> Content
    
    init(
        onOffsetChange: @escaping (CGFloat) -> Void,
        @ViewBuilder content: @escaping () -> Content) {
        self.onOffsetChange = onOffsetChange
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            offsetReader
            content()
                .padding(.top, -8) // this places the real content as if our `offsetReader` was not there.
        }
        .coordinateSpace(name: "frameLayer")
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
    }
    
    var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .named("frameLayer")).minY)
        }
        .frame(height: 0) // this makes sure that the reader doesn't affect the content height
    }
}

/// Contains the gap between the smallest value for the y-coordinate of
/// the frame layer and the content layer.
private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
    }
}

struct ScrollViewExample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewExample()
    }
}
