//
//  SetupProjectView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct SetupProjectView: View {
    
    @Binding var project: ProjectModel
    @Binding var canSubmit: Bool
    
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        Section {
            CustomTextField(text: $project.name, title: "Name")
                .onChange(of: project.name) {
                    canSubmit = !project.name.isEmpty ? true : false
                }
        }
        Section {
            ForEach($project.counters) { $counter in
                LabeledContent(counter.name) {
                    HStack {
                        if project.withRowGoal {
                            Text(String(counter.rowsAmount!))
                                .foregroundStyle(.gray)
                        }
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                            .font(.caption)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.presentSheet(.editCounterView(
                        counter: $counter,
                        project: $project,
                        origin: .projectView
                    ))
                }
            }
            Button {
                coordinator.presentSheet(.newCounterView(
                    project: $project
                ))
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .foregroundStyle(.blue)
                    Text("New counter")
                        .foregroundStyle(.blue)
                }
            }
        } header: {
            Text("Counters")
        }
    }
    
    func withDeleteButton<DeleteButton: View>(
        @ViewBuilder makeButton: @escaping () -> DeleteButton
    ) -> some View {
        List {
            self
            makeButton()
        }
    }
    
    func withoutDeleteButton() -> some View {
        List {
            self
        }
    }
}

