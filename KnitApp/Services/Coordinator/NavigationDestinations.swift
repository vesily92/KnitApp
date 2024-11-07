//
//  NavigationDestinations.swift
//  KnitApp
//
//  Created by Vasily Pronin on 06.11.2024.
//

import SwiftUI

enum ScreenDestination {
    
    case homeView(ProjectManager)
    case projectView(project: Binding<ProjectModel>)
}

extension ScreenDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .homeView(let viewModel):
            hasher.combine(viewModel)
        case .projectView(let projectModel):
            hasher.combine(projectModel.wrappedValue)
        }
    }
    
    static func == (lhs: ScreenDestination, rhs: ScreenDestination) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

enum SheetDestination: Identifiable {
    
    case onboardingView
    
    var id: String {
        switch self {
        case .onboardingView:
            return "0"
        }
    }
}

extension SheetDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .onboardingView: break
        }
    }
    
    static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

