//
//  Filter.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

enum FilterOption: String, CaseIterable {
    case all = "All"
    case active = "In progress"
    case finished = "Finished"
}

struct FilterItem: Identifiable, Equatable {
    
    let id = UUID()
    let option: FilterOption
    let count: Int
    var isPressed = false
}
