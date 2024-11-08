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
    @State private var filteredProjects: [ProjectModel] = []
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            ScrollView {
                if viewModel.showBanner {
                    GetAppleWatchAppView(isPresented: $viewModel.showBanner)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
                ScrollView(.horizontal) {
                    FilterView(
                        currentFilter: $viewModel.appliedFilter,
                        items: $viewModel.filteringItems
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
                LazyVStack(spacing: 2) {
                    ForEach($filteredProjects) { $project in
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
            .searchable(text: $viewModel.searchText)
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
                filteredProjects = viewModel.filterProjects()
                viewModel.updateFilteringItems()
            }
            .onChange(of: viewModel.appliedFilter) {
                withAnimation {
                    filteredProjects = viewModel.filterProjects()
                    viewModel.updateFilteringItems()
                }
            }
            .onChange(of: viewModel.projects) {
                withAnimation {
                    filteredProjects = viewModel.filterProjects()
                    viewModel.updateFilteringItems()
                }
            }
            .onChange(of: viewModel.searchText) {
                withAnimation {
                    filteredProjects = viewModel.filterProjects()
                }
            }
        }
    }
    
    init(viewModel: ProjectManager) {
        self.viewModel = viewModel
    }
}
