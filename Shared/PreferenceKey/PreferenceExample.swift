//
//  PreferenceExample.swift
//  Learn-SwiftUI (iOS)
//
//  Created by CJS on 2021/8/1.
//

import SwiftUI

struct PreferenceExample: View {
    
    @State private var activeIndex: Int = 0
//    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 12)
    
    var body: some View {
//        ZStack(alignment: .topLeading) {
//            RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 3.0).foregroundColor(Color.green)
//                .frame(width: rects[activeIndex].size.width, height: rects[activeIndex].size.height)
//                .offset(x: rects[activeIndex].minX, y: rects[activeIndex].minY)
//                .animation(.easeInOut(duration: 1.0))
            
            VStack {
                Spacer()
                
                HStack {
                    MonthView(activeMonth: $activeIndex, label: "January", idx: 0)
                    MonthView(activeMonth: $activeIndex, label: "February", idx: 1)
                    MonthView(activeMonth: $activeIndex, label: "March", idx: 2)
                    MonthView(activeMonth: $activeIndex, label: "April", idx: 3)
                }
                
                Spacer()
                
                HStack {
                    MonthView(activeMonth: $activeIndex, label: "May", idx: 4)
                    MonthView(activeMonth: $activeIndex, label: "June", idx: 5)
                    MonthView(activeMonth: $activeIndex, label: "July", idx: 6)
                    MonthView(activeMonth: $activeIndex, label: "August", idx: 7)
                }
                
                Spacer()
                
                HStack {
                    MonthView(activeMonth: $activeIndex, label: "September", idx: 8)
                    MonthView(activeMonth: $activeIndex, label: "October", idx: 9)
                    MonthView(activeMonth: $activeIndex, label: "November", idx: 10)
                    MonthView(activeMonth: $activeIndex, label: "December", idx: 11)
                }
                
                Spacer()
            }
            .backgroundPreferenceValue(MyTextPreferenceKey.self) { preferences in
                GeometryReader { geometry in
                    self.createBorder(geometry, preferences)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
//            .onPreferenceChange(MyTextPreferenceKey.self, perform: { preferences in
//                for p in preferences {
//                    self.rects[p.viewIdx] = p.rect
//                }
//            })
//        }
//        .coordinateSpace(name: "myZstack")
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceData]) -> some View {
        let p = preferences.first(where: {
            return $0.viewIdx == self.activeIndex
        })
        let bounds = p != nil ? geometry[p!.bounds] : .zero
        return RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0)
            .foregroundColor(.green)
            .frame(width: bounds.size.width, height: bounds.size.height)
//            .fixedSize()
            .offset(x: bounds.minX, y: bounds.minY)
            .animation(.easeInOut(duration: 1.0))
    }
}

struct MyTextPreferenceData: Equatable {
    static func == (lhs: MyTextPreferenceData, rhs: MyTextPreferenceData) -> Bool {
        lhs.viewIdx == rhs.viewIdx
    }
    
    let viewIdx: Int
//    let rect: CGRect
    let bounds: Anchor<CGRect>
}

struct MyTextPreferenceKey: PreferenceKey {
    typealias Value = [MyTextPreferenceData]
    
    static var defaultValue: [MyTextPreferenceData] = []
    
    static func reduce(value: inout [MyTextPreferenceData], nextValue: () -> [MyTextPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct MonthView: View {
    @Binding var activeMonth: Int
    let label: String
    let idx: Int
    
    var body: some View {
        Text(label)
            .padding(10)
//            .onTapGesture {
//                self.activeMonth = self.idx
//            }
//            .background(MonthBorder(show: activeMonth == idx))
//            .background(MyPreferenceViewSetter(idx: idx))
            .anchorPreference(key: MyTextPreferenceKey.self, value: .bounds, transform: {
                print("bounds=\($0)")
                return [MyTextPreferenceData(viewIdx: self.idx, bounds: $0)]
            })
            .onTapGesture {
                self.activeMonth = self.idx
            }
    }
}

//struct MyPreferenceViewSetter: View {
//    let idx: Int
//
//    var body: some View {
//        GeometryReader { geometry in
//            Rectangle()
//                .fill(Color.clear)
//                .preference(key: MyTextPreferenceKey.self, value: [MyTextPreferenceData(viewIdx: self.idx, rect: geometry.frame(in: .named("myZstack")))])
//        }
//    }
//}

struct MonthBorder: View {
    let show: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0).foregroundColor(show ? Color.red : Color.clear)
            .animation(.easeInOut(duration: 0.6))
    }
}

struct PreferenceExample_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceExample()
    }
}
