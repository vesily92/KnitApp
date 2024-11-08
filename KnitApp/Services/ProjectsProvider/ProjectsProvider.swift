//
//  ProjectsProvider.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

actor ProjectProvider {
    
    private var projects = [
        ProjectModel(name: "Sweater", counters: [Counter(name: "Sleeve", currentRow: 71, rowsAmount: 150)]),
        ProjectModel(name: "Scarf", counters: [
            Counter(name: "Body", currentRow: 71, rowsAmount: 150),
            Counter(name: "untitled1", currentRow: 71, rowsAmount: 150),
            Counter(name: "untitled 2", currentRow: 71, rowsAmount: 150),
            Counter(name: "untitled", currentRow: 71, rowsAmount: 150),
            Counter(name: "untitled 0", currentRow: 71, rowsAmount: 150),
            Counter(name: "untitled 23", currentRow: 71, rowsAmount: 150),
            Counter(name: "12untitled", currentRow: 71, rowsAmount: 150)
        ]),
        ProjectModel(name: "Babushka square1", counters: [Counter(name: "", currentRow: 71, rowsAmount: 150)]),
        ProjectModel(name: "Babushka square2", counters: [Counter(name: "main", currentRow: 71, rowsAmount: 150)]),
        ProjectModel(name: "My favourite babushka square", counters: []),
    ]
    
    func fetchProjects() -> [ProjectModel] {
        projects
    }
}
