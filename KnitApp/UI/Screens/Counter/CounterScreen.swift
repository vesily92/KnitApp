//
//  CounterScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct CounterScreen: View {
    
    @Binding var counter: Counter
    @Binding var project: ProjectModel
    
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Button("Tap to add row") {
                        increment()
                    }
                    .foregroundStyle(.blue)
                    .opacity(counter.currentRow > 0 ? 0 : 1)
                    Text(String(counter.currentRow))
                        .font(.system(size: 211, weight: .semibold))
                    if let amount = counter.rowsAmount {
                        Text("out of " + String(amount))
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    increment()
                }
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Row back")
                }
                .opacity(counter.currentRow > 0 ? 1 : 0)
                .foregroundStyle(.blue)
                .onTapGesture {
                    decrement()
                }
            }
        }
        .navigationTitle(counter.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit") {
                coordinator.presentSheet(.editCounterView(
                    counter: $counter,
                    project: $project,
                    origin: .counterView
                ))
            }
        }
    }
    
    private func tapToAddButton() -> some View {
        Button("Tap to add row") {
            increment()
        }
        .foregroundStyle(.blue)
        .opacity(counter.currentRow > 0 ? 0 : 1)
    }
    
    private func increment() {
        let rowGoal = counter.rowsAmount ?? Int.max
        
        if counter.currentRow < rowGoal {
            counter.currentRow += 1
        } else { return }
    }
    
    private func decrement() {
        if counter.currentRow > 0 {
            counter.currentRow -= 1
        } else { return }
    }
}

//#Preview {
//    struct Preview: View {
//        @State private var counter = Counter(name: "Sweater", rowsAmount: 13, currentRow: 2)
//        var body: some View {
//            CounterScreen(counter: $counter)
//        }
//    }
//
//    return Preview()
//}

