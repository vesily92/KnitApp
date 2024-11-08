//
//  NewCounterScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct NewCounterScreen: View {
    
    @Binding var project: ProjectModel
    
    @State private var viewModel: SetupCounterViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    CustomTextField(
                        text: $viewModel.nameString,
                        title: "Name"
                    )
                }
                Section {
                    Toggle(isOn: $viewModel.rowGoalIsOn) {
                        Text("Row goal")
                    }
                    if viewModel.rowGoalIsOn {
                        CustomTextField(
                            text: $viewModel.rowsAmountString,
                            title: "Amount",
                            inputType: .numeric
                        )
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
                    Button("Create") {
                        project.counters.append(viewModel.createNewCounter())
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(project: Binding<ProjectModel>) {
        self._project = project
        
        viewModel = SetupCounterViewModel(project: project.wrappedValue)
    }
}

//#Preview {
//    NewCounterScreen()
//}

