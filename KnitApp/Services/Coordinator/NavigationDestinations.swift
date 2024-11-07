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
    case newCounterView(project: Binding<ProjectModel>)
    case editCounterView(counter: Binding<Counter>, project: Binding<ProjectModel>, origin: EditCounterScreen.OriginView)
    
    var id: String {
        switch self {
        case .onboardingView:
            return "0"
        case .newProjectView:
            return "1"
        case .editProjectView(let project):
            return "2. \(project.id)"
        case .newCounterView(let project):
            return "3. \(project.id)"
        case .editCounterView(let counter, let project, _):
            return "4. \(counter.id)\(project.id)"
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
        case .newCounterView(let binding):
            hasher.combine(binding.wrappedValue)
        case .editCounterView(let counter, let project, let origin):
            hasher.combine(counter.wrappedValue)
            hasher.combine(project.wrappedValue)
            hasher.combine(origin)
        }
    }
    
    static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

