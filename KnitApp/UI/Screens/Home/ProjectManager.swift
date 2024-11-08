//
//  ProjectManager.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

@Observable
final class ProjectManager: ViewModel {
    
    
    var projects: [ProjectModel] = []
    var filteringItems: [FilterItem] = []
    var appliedFilter: FilterOption = .all 
    var searchText = ""
    var showBanner = true
    var firstLaunch: Bool = true
        
    private let projectProvider: ProjectProvider
    
    init(projectProvider: ProjectProvider) {
        self.projectProvider = projectProvider
        
        Task {
            projects = await projectProvider.fetchProjects()
            filteringItems = prepareFilteringItems()
        }
    }
    
    func filterProjects() -> [ProjectModel] {
        var filteredProjects: [ProjectModel] = []
        
        switch appliedFilter {
        case .all:
            filteredProjects = projects.sorted { lhs, rhs in
                !lhs.isFinished && rhs.isFinished
            }
        case .active:
            filteredProjects = projects.filter { project in
                project.isFinished == false
            }
        case .finished:
            filteredProjects = projects.filter { project in
                project.isFinished == true
            }
        }
        
        return search(in: filteredProjects)
    }
    
    func updateFilteringItems() {
        filteringItems = prepareFilteringItems(appliedFilter)
    }
    
    func addProject(_ project: ProjectModel) {
        projects.append(project)
    }
    
    func updateProject(_ project: ProjectModel) {
        if let index = self.projects.firstIndex(where: {$0.id == project.id }) {
            projects[index] = project
        }
    }
    
    func deleteProject(_ project: ProjectModel) {
        if let index = self.projects.firstIndex(where: {$0.id == project.id }) {
            projects.remove(at: index)
        }
    }
    
    private func search(in projects: [ProjectModel]) -> [ProjectModel] {
        if searchText.isEmpty {
            return projects
        } else {
            return projects.filter { $0.name.contains(searchText) }
        }
    }
    
    private func prepareFilteringItems(
        _ appliedFilter: FilterOption = .all
    ) -> [FilterItem] {
        let options = FilterOption.allCases
        
        var items: [FilterItem] = []
        
        options.forEach { option in
            items.append(
                FilterItem(
                    option: option,
                    count: countProjects(with: option),
                    isPressed: option == appliedFilter
                )
            )
        }
        
        return items
    }
    
    private func countProjects(with filter: FilterOption) -> Int {
        let total = projects.count
        let finished = projects.filter { $0.isFinished }.count
        
        switch filter {
        case .all:
            return total
        case .active:
            return total - finished
        case .finished:
            return finished
        }
    }
}

