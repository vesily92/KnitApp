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
    case counterView(counter: Binding<Counter>, project: Binding<ProjectModel>)
}

extension ScreenDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .homeView(let viewModel):
            hasher.combine(viewModel)
        case .projectView(let projectModel):
            hasher.combine(projectModel.wrappedValue)
        case .counterView(let counter, let project):
            hasher.combine(counter.wrappedValue)
            hasher.combine(project.wrappedValue)
        }
    }
    
    static func == (lhs: ScreenDestination, rhs: ScreenDestination) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

enum SheetDestination: Identifiable {
    
    case onboardingView
    case newProjectView
    case editProjectView(ProjectModel)
    
    var id: String {
        switch self {
        case .onboardingView:
            return "0"
        case .newProjectView:
            return "1"
        case .editProjectView(let project):
            return "2. \(project.id)"
        }
    }
}

extension SheetDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .onboardingView: break
        case .newProjectView: break
        case .editProjectView(let project):
            hasher.combine(project)
        }
    }
    
    static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

