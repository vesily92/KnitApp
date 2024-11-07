//
//  ProjectModel.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

@Observable
final class ProjectModel: Identifiable {
    
    let id = UUID()
    var name: String
    var counters: [Counter]
    
    var rowsDone: Int {
        guard !counters.isEmpty else { return 0 }
        return counters.reduce(0, { $0 + $1.currentRow })
    }
    
    var isFinished: Bool {
        guard !counters.isEmpty else { return false }
        return rowsRemain == 0
    }
    
    var withRowGoal: Bool {
        guard !counters.isEmpty else { return false }
        guard !counters.contains(where: { $0.rowGoalIsOn == false }) else { return false }
        return true
    }
    
    var totalRowsAmount: Int? {
        guard !counters.isEmpty else { return nil }
        guard !counters.contains(where: { $0.rowGoalIsOn == false }) else { return nil}
        return counters.compactMap { $0.rowsAmount }.reduce(0, { $0 + $1 })
    }
    var rowsRemain: Int? {
        guard !counters.isEmpty else { return nil }
        guard let totalRowsAmount = totalRowsAmount else { return nil }
        return totalRowsAmount - rowsDone
    }
    var progress: Double? {
        guard !counters.isEmpty else { return nil }
        guard let totalRowsAmount = totalRowsAmount else { return nil }
        return Double(rowsDone) / Double(totalRowsAmount)
    }
    
    init(name: String, counters: [Counter]) {
        self.name = name
        self.counters = counters
    }
    
    func copy() -> ProjectModel {
        let project = ProjectModel(name: name, counters: counters)
        return project
    }
}

extension ProjectModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(counters)
    }
    
    static func == (lhs: ProjectModel, rhs: ProjectModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
