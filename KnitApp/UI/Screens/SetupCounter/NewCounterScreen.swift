//
//  NewCounterScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct NewCounterScreen: View {
    
    @Binding var project: ProjectModel
    
    @State private var counterName = ""
    @State private var rowsAmount = ""
    @State private var rowGoalIsOn = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    CustomTextField(text: $counterName, title: "Name")
                }
                Section {
                    Toggle(isOn: $rowGoalIsOn) {
                        Text("Row goal")
                    }
                    if rowGoalIsOn {
                        CustomTextField(text: $rowsAmount, title: "Amount", inputType: .numeric)
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
                        let name = counterName.isEmpty ? "Untitled" : counterName
                        let counter = Counter(name: name, rowsAmount: Int(rowsAmount))
                        project.counters.append(counter)
                        
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(project: Binding<ProjectModel>) {
        self._project = project
    }
}

//#Preview {
//    NewCounterScreen()
//}

