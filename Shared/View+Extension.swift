//
//  View+Extension.swift
//  Learn-SwiftUI (iOS)
//
//  Created by CJS on 2021/8/7.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ conditoin: Bool,
        if ifTransform: (Self) -> TrueContent,
        else elseTransform: (Self) -> FalseContent
    ) -> some View {
        if conditoin {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    @ViewBuilder
    func ifLet<V, Transform: View>(
        _ value: V?,
        transform: (Self, V) -> Transform
    ) -> some View {
        if let value = value {
            transform(self, value)
        }else {
            self
        }
    }
    
    @available(iOS, introduced: 13, deprecated: 14, message: "Use .ignoresSafeArea(.keyboard) directly")
    @ViewBuilder
    func ignoreKeyboard() -> some View {
        if #available(iOS 14.0, *) {
            ignoresSafeArea(.keyboard)
        } else {
            self // iOS 13 always ignores the keyboard
        }
    }
    
    #if iOS
    @available(iOS, introduced: 13, deprecated: 14, message: "Use .listStyle(InsetGroupedListStyle()) directly")
    @ViewBuilder
    func insetGroupedListStyle() -> some View {
        if #available(iOS 14.0, *) {
            self.listStyle(InsetGroupedListStyle())
        } else {
            self.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
        }
    }
    #endif
}
