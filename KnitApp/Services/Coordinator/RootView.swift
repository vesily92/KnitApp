//
//  RootView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct RootView: View {
    
    var viewModel = ProjectManager(projectProvider: ProjectProvider())
    
    var body: some View {
        CoordinatorView {
            HomeScreen(viewModel: viewModel)
        }
        .environment(viewModel)
    }
}
