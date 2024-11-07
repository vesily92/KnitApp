//
//  ProjectView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct ProjectView: View {
    
    @Binding var project: ProjectModel
    
    @Environment(Coordinator.self) private var coordinator
    @Environment(ProjectManager.self) private var viewModel
    
    @State private var showAlert: Bool = false
    @State private var toBeDeleted: Counter?
    
    
    var body: some View {
        List {
            ForEach($project.counters) { $counter in
                Section {
                    CounterPreviewCell(counter: counter)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                toBeDeleted = counter
                                showAlert = true
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                            Button {
                                coordinator.presentSheet(.editProjectView(project))
                            } label: {
                                Image(systemName: "gearshape.fill")
                            }
                            .tint(.orange)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.push(.counterView(counter: $counter, project: $project))
                        }
                }
            }
            .alert("Are you sure you want to delete counter?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    withAnimation {
                        delete(counter: toBeDeleted)
                    }
                }
            }
        }
        .listSectionSpacing(16)
        .navigationTitle(project.name)
        .toolbar {
            Button("Edit") {
                coordinator.presentSheet(.editProjectView(project))
            }
        }
    }
    
    private func delete(counter: Counter?) {
        guard let counter = counter else { return }
        
        if let index = self.project.counters.firstIndex(where: {$0.id == counter.id }) {
            project.counters.remove(at: index)
        }
    }
}

//#Preview {
//    ProjectView()
//}
