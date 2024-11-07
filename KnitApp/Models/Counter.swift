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
    var name: String?
    var rowsAmount: Int?
    var currentRow: Int = 0
    
    var rowGoalIsOn: Bool {
        rowsAmount != nil
    }
    
    init(name: String? = nil, rowsAmount: Int? = nil, currentRow: Int = 0) {
        self.name = name
        self.rowsAmount = rowsAmount
        self.currentRow = currentRow
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
