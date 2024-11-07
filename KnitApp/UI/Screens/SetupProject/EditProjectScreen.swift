//
//  EditProjectScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct EditProjectScreen: View {
    
    //    @Binding var project: ProjectModel
    
    @Environment(Coordinator.self) private var router
    @Environment(\.dismiss) private var dismiss
    @Environment(ProjectManager.self) private var viewModel
    
    @State private var editableProject: ProjectModel
    @State private var canSubmit: Bool = true
    @State private var isDeleting: Bool = false
    
    private let project: ProjectModel
    
    var body: some View {
        NavigationView {
            VStack {
                SetupProjectView(project: $editableProject, canSubmit: $canSubmit)
                    .withDeleteButton {
                        Button("Delete project", role: .destructive) {
                            isDeleting.toggle()
                        }
                        .alert("Are you sure you want to delete project?", isPresented: $isDeleting) {
                            Button("Delete", role: .destructive) {
                                viewModel.deleteProject(project)
                                router.popToRoot()
                                dismiss()
                            }
                        }
                    }
                    .listSectionSpacing(16)
                    .navigationTitle("Edit project")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Save") {
                                updateProject()
                                dismiss()
                            }
                            .disabled(!canSubmit)
                        }
                    }
            }
        }
    }
    
    //    init(project: Binding<ProjectModel>) {
    //        self._project = project
    //
    //        editableProject = project.wrappedValue
    //
    //    }
    
    init(project: ProjectModel) {
        self.project = project
        self.editableProject = project.copy()
    }
    
    private func updateProject() {
        project.name = editableProject.name
        project.counters = editableProject.counters
        
        viewModel.updateProject(project)
    }
}

//#Preview {
//    EditProjectScreen()
//}

