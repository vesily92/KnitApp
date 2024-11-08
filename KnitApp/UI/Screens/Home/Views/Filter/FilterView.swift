//
//  FilterView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var appliedFilter: FilterOption
    @Binding var items: [FilterItem]
    
    var body: some View {
        HStack {
            ForEach($items) { $option in
                HStack {
                    Toggle(isOn: $option.isPressed) {
                        HStack {
                            Text(option.option.rawValue)
                                .foregroundStyle(
                                    option.option == appliedFilter
                                    ? Color.accentColor
                                    : Color.primary
                                )
                                .lineLimit(1)
                            
                            Text(String(option.count))
                                .foregroundStyle(Color.secondary)
                        }
                    }
                    .toggleStyle(.button)
                    .tint(.clear)
                    .onChange(of: option, initial: option.isPressed) {
                        if option.isPressed {
                            self.appliedFilter = option.option
                            self.items = self.items.map {
                                var item = $0
                                item.isPressed = $0.id == option.id
                                return item
                            }
                        }
                    }
                }
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(12)
                
                Spacer()
            }
        }
    }
    
    init(currentFilter: Binding<FilterOption>, items: Binding<[FilterItem]>) {
        self._appliedFilter = currentFilter
        self._items = items
    }
}

//#Preview {
//    struct Preview: View {
//        @State var option = FilterItem(option: .all, count: 5, isPressed: true)
//        @State var items = [
//            FilterItem(option: .all, count: 5, isPressed: true),
//            FilterItem(option: .active, count: 4),
//            FilterItem(option: .finished, count: 1)
//        ]
//        var body: some View {
//            FilterView(
//                currentOption: $option,
//                items: $items
//            )
//        }
//    }
//
//    return Preview()
//}

