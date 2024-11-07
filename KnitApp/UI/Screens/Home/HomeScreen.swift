//
//  HomeScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(Coordinator.self) private var coordinator
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var viewModel: ProjectManager
    @State private var filter: FilterOption = .all
    @State private var searchText = ""
    @State private var isPresentingBanner = true
    
    private var projects: [Binding<ProjectModel>] {
        let bindingProjects = $viewModel.projects.map { $project in
            return $project
        }
        var filteredProjects: [Binding<ProjectModel>] = []
        
        switch filter {
        case .all:
            filteredProjects = bindingProjects.sorted { lhs, rhs in
                !lhs.wrappedValue.isFinished && rhs.wrappedValue.isFinished
            }
        case .active:
            filteredProjects = bindingProjects.filter { project in
                project.wrappedValue.isFinished == false
            }
        case .finished:
            filteredProjects = bindingProjects.filter { project in
                project.wrappedValue.isFinished == true
            }
        }
        return filteredProjects
    }
    
    private var searchResults: [Binding<ProjectModel>] {
        if searchText.isEmpty {
            return projects
        } else {
            return projects.filter { $0.wrappedValue.name.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            ScrollView {
                if isPresentingBanner {
                    GetAppleWatchAppView(isPresented: $isPresentingBanner)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
                ScrollView(.horizontal) {
                    FilterView(
                        currentFilter: $filter,
                        items: $viewModel.filteringItems
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
                LazyVStack(spacing: 2) {
                    ForEach(searchResults) { $project in
                        ProjectPreviewCell($project)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                coordinator.push(.projectView(project: $project))
                            }
                        Divider()
                            .padding(.leading)
                    }
                    Button {
                        coordinator.presentSheet(.newProjectView)
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("New project")
                            Spacer()
                        }
                        .foregroundStyle(.blue)
                        .padding(.vertical, 11)
                        .padding(.horizontal)
                    }
                }
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            .navigationTitle("My projects")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem {
                    Button {
                        coordinator.presentSheet(.newProjectView)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .onAppear {
                viewModel.updateFilteringItems(with: filter)
            }
        }
    }
    
    init(viewModel: ProjectManager) {
        self.viewModel = viewModel
    }
}
