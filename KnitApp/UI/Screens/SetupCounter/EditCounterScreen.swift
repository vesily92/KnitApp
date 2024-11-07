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
    
    @State private var nameString: String
    @State private var currentRowString: String
    @State private var rowsAmountString: String
    @State private var rowGoalIsOn: Bool
    @State private var canSubmit: Bool = false
    @State private var showAlert: Bool = false
    
    private let rowAmount: Int
    private let origin: OriginView
    
    @Environment(\.dismiss) private var dismiss
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    CustomTextField(text: $nameString, title: "Name")
                        .onChange(of: nameString) {
                            trackChanges()
                        }
                }
                Section {
                    CustomTextField(text: $currentRowString, title: "Current row", inputType: .numeric)
                        .onChange(of: currentRowString) {
                            trackChanges()
                            print(currentRowString)
                        }
                }
                Section {
                    Toggle(isOn: $rowGoalIsOn) {
                        Text("Row goal")
                    }
                    .onChange(of: rowGoalIsOn) {
                        trackChanges()
                    }
                    if rowGoalIsOn {
                        CustomTextField(text: $rowsAmountString, title: "Amount", inputType: .numeric)
                            .onChange(of: rowsAmountString) {
                                trackChanges()
                            }
                    }
                }
                Section {
                    Button("Delete counter", role: .destructive) {
                        showAlert = true
                    }
                    .alert("Are you sure you want to delete counter?", isPresented: $showAlert) {
                        Button("Delete", role: .destructive) {
                            deleteCounter()
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
                        counter = makeUpdatedCounter()
                        dismiss()
                    }
                    .disabled(!canSubmit)
                }
            }
        }
    }
    
    init(counter: Binding<Counter>, project: Binding<ProjectModel>, origin: OriginView) {
        self._counter = counter
        self._project = project
        self.origin = origin
        
        nameString = counter.wrappedValue.name ?? ""
        currentRowString = String(counter.wrappedValue.currentRow)
        rowGoalIsOn = counter.wrappedValue.rowGoalIsOn
        
        if let unwrappedAmount = counter.wrappedValue.rowsAmount {
            rowAmount = unwrappedAmount
            rowsAmountString = String(unwrappedAmount)
        } else {
            rowAmount = 100
            rowsAmountString = "100"
        }
    }
    
    private func trackChanges() {
        let nameWasChanged = nameString != counter.name
        let currentRowWasChanged = currentRowString != String(counter.currentRow)
        let rowAmountWasChanged = rowsAmountString != String(rowAmount)
        let currentRowInBounds = rowAmount >= Int(currentRowString) ?? rowAmount
        let rowGoalIsOnWasChanged = rowGoalIsOn != counter.rowGoalIsOn
        
        let fieldsWereChanged = nameWasChanged
        || currentRowWasChanged
        || rowAmountWasChanged
        || rowGoalIsOnWasChanged
        
        if fieldsWereChanged {
            if rowGoalIsOn && currentRowInBounds {
                canSubmit = true
            } else if rowGoalIsOn == false {
                canSubmit = true
            } else {
                canSubmit = false
            }
        } else {
            canSubmit = false
        }
    }
    
    private func makeUpdatedCounter() -> Counter {
        let name = nameString.isEmpty ? "Untitled" : nameString
        return Counter(
            name: name,
            rowsAmount: rowGoalIsOn ? Int(rowsAmountString) : nil,
            currentRow: self.counter.currentRow
        )
    }
    
    private func deleteCounter() {
        if let index = self.project.counters.firstIndex(where: {$0.id == counter.id }) {
            project.counters.remove(at: index)
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var counter = Counter(name: "Some name", rowsAmount: 100, currentRow: 20)
        @State private var project = ProjectModel(name: "Ivan", counters: [])
        var body: some View {
            EditCounterScreen(counter: $counter, project: $project, origin: .counterView)
        }
    }
    
    return Preview()
}
