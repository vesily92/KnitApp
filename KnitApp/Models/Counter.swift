//
//  Counter.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

@Observable
final class Counter: Identifiable {
    
    let id = UUID()
    var name: String
    var currentRow: Int = 0
    var rowsAmount: Int?
    
    var rowGoalIsOn: Bool {
        rowsAmount != nil
    }
    
    init(name: String, currentRow: Int = 0, rowsAmount: Int? = nil) {
        self.name = name
        self.currentRow = currentRow
        self.rowsAmount = rowsAmount
    }
}

extension Counter: Hashable {
    static func == (lhs: Counter, rhs: Counter) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(rowsAmount)
        hasher.combine(currentRow)
        hasher.combine(rowGoalIsOn)
    }
}
