//
//  NewProjectScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct NewProjectScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(ProjectManager.self) private var viewModel
    @Environment(Coordinator.self) private var coordinator
    
    @State private var newProject = ProjectModel(name: "", counters: [])
    @State private var canSubmit: Bool = false
    
    var body: some View {
        NavigationView {
            SetupProjectView(project: $newProject, canSubmit: $canSubmit)
                .withoutDeleteButton()
                .listSectionSpacing(16)
                .navigationTitle("New project")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Create") {
                            viewModel.addProject(newProject)
                            dismiss()
                            coordinator.push(.projectView(project: $newProject))
                            
                        }
                        .disabled(!canSubmit)
                    }
                }
        }
    }
}

#Preview {
    NewProjectScreen()
}

