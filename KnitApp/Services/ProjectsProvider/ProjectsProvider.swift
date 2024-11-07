//
//  ProjectsProvider.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

actor ProjectProvider {
    
    private var projects = [
        ProjectModel(name: "Sweater", counters: [Counter(name: "Sleeve", rowsAmount: 100, currentRow: 99)]),
        ProjectModel(name: "Scarf", counters: [Counter(name: "Body", rowsAmount: 150, currentRow: 71)]),
        ProjectModel(name: "Babushka square1", counters: [Counter(name: "", rowsAmount: 10, currentRow: 2)]),
        ProjectModel(name: "Babushka square2", counters: [Counter(name: "main", rowsAmount: 10, currentRow: 10)]),
        ProjectModel(name: "My favourite babushka square", counters: []),
    ]
    
    func fetchProjects() -> [ProjectModel] {
        projects
    }
}
