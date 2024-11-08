//
//  EditCounterScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct EditCounterScreen: View {
    
    enum OriginView {
        case counterView
        case projectView
    }
    
    @Binding var counter: Counter
    @Binding var project: ProjectModel
    
    @State private var viewModel: SetupCounterViewModel
    
    private let origin: OriginView
    
    @Environment(\.dismiss) private var dismiss
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    CustomTextField(
                        text: $viewModel.nameString,
                        title: "Name"
                    )
                    .onChange(of: viewModel.nameString) {
                        viewModel.trackChanges()
                    }
                }
                Section {
                    CustomTextField(
                        text: $viewModel.currentRowString,
                        title: "Current row",
                        inputType: .numeric
                    )
                    .onChange(of: viewModel.currentRowString) {
                        viewModel.trackChanges()
                    }
                }
                Section {
                    Toggle(isOn: $viewModel.rowGoalIsOn) {
                        Text("Row goal")
                    }
                    .onChange(of: viewModel.rowGoalIsOn) {
                        viewModel.trackChanges()
                    }
                    if viewModel.rowGoalIsOn {
                        CustomTextField(
                            text: $viewModel.rowsAmountString,
                            title: "Amount",
                            inputType: .numeric
                        )
                        .onChange(of: viewModel.rowsAmountString) {
                            viewModel.trackChanges()
                        }
                    }
                }
                Section {
                    Button("Delete counter", role: .destructive) {
                        viewModel.showAlert = true
                    }
                    .alert("Are you sure you want to delete counter?", isPresented: $viewModel.showAlert) {
                        Button("Delete", role: .destructive) {
                            project.counters.remove(
                                at: viewModel.getIndexToDelete()
                            )
                            switch origin {
                            case .counterView:
                                coordinator.pop(
                                    route: .projectView(project: $project)
                                )
                            case .projectView:
                                dismiss()
                            }
                            dismiss()
                        }
                    }
                }
            }
            .listSectionSpacing(16)
            .navigationTitle("Edit counter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        counter = viewModel.makeUpdatedCounter()
                        dismiss()
                    }
                    .disabled(!viewModel.canSubmit)
                }
            }
        }
    }
    
    init(
        counter: Binding<Counter>,
        project: Binding<ProjectModel>,
        origin: OriginView
    ) {
        self._counter = counter
        self._project = project
        self.origin = origin
        
        viewModel = SetupCounterViewModel(
            project: project.wrappedValue,
            counter: counter.wrappedValue
        )
    }
}

#Preview {
    struct Preview: View {
        @State private var counter = Counter(name: "Some name", currentRow: 71, rowsAmount: 150)
        @State private var project = ProjectModel(name: "Ivan", counters: [])
        var body: some View {
            EditCounterScreen(counter: $counter, project: $project, origin: .counterView)
        }
    }
    
    return Preview()
}
