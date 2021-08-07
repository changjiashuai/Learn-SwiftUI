//
//  LabelExample.swift
//  Learn-SwiftUI (iOS)
//
//  Created by CJS on 2021/8/7.
//

import SwiftUI

struct LabelExample: View {
    var body: some View {
        VStack {
            Group {
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(IconOnlyLabelStyle())
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(TitleOnlyLabelStyle())
            
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(DefaultLabelStyle())
                
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(ShadowLabelStyle())
            }
        
            Group {
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(ShadowLabelStyle())
                    .labelStyle(IconOnlyLabelStyle())
                
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(IconOnlyLabelStyle()) //Note: the order of style
                    .labelStyle(ShadowLabelStyle())
                
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(ShadowEraseLabelStyle()) //Note: apply multiple styles
                    .labelStyle(TitleOnlyLabelStyle())
                    .labelStyle(IconOnlyLabelStyle())
                
                Label("Title", systemImage: "moon.circle.fill")
                    .labelStyle(ShadowLabelTryStyle())
                    .labelStyle(IconOnlyLabelStyle())
            }
            
            Group {
                Label("Swap Title And Icon", systemImage: "moon.circle.fill")
                    .labelStyle(SwapLabelStyle())
                    .labelStyle(IconOnlyLabelStyle())
                
                Label("Change Content Container", systemImage: "moon.circle.fill")
                    .labelStyle(HStackLabelStyle())
                    .labelStyle(ShadowLabelStyle())
                    .labelStyle(IconOnlyLabelStyle())
                
                Label("Change Content Container the order of styels", systemImage: "moon.circle.fill")
                    .labelStyle(ShadowLabelStyle())
                    .labelStyle(IconOnlyLabelStyle())
                    .labelStyle(HStackLabelStyle())
            }
            
            Label("Title Color Icon", colorfulSystemImage: "moon.circle.fill")
                .labelStyle(ShadowLabelStyle())
           
        }
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ title: LocalizedStringKey, colorfulSystemImage systemImage: String) {
        self.init(
            title: { Text(title) },
            icon: { Image(systemName: systemImage).renderingMode(.original) }
        )
    }
}

///System Content Size Changed.
struct AccessibleLabelStyle: LabelStyle {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .if(sizeCategory.isAccessibilityCategory) {
                $0.labelStyle(TitleOnlyLabelStyle())
            }
    }
}

struct HStackLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            Spacer()
            configuration.title
        }
    }
}

struct SwapLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label(
            title: { configuration.icon },
            icon: { configuration.title }
        )
    }
}

/// tried to erase the style also by passing the two configuration views to new Label
struct ShadowLabelTryStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(
            title: { configuration.icon },
            icon: { configuration.title }
        )
        .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 0, y: 5)
    }
}

struct ShadowEraseLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 0, y: 5)
            .labelStyle(DefaultLabelStyle())
    }
}

struct ShadowLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 0, y: 5)
    }
}

struct LabelExample_Previews: PreviewProvider {
    static var previews: some View {
        LabelExample()
    }
}
