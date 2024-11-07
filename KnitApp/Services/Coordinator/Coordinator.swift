//
//  Coordinator.swift
//  KnitApp
//
//  Created by Vasily Pronin on 06.11.2024.
//

import SwiftUI

@MainActor
@Observable
final class Coordinator {
    
    var path = NavigationPath()
    
    var sheetFirst: SheetDestination?
    var sheetSecond: SheetDestination?
    
    @ViewBuilder
    func view(for destination: ScreenDestination) -> some View {
        switch destination {
        case .homeView(let model):
            HomeScreen(viewModel: model)
        case .projectView(let project):
            ProjectScreen(project: project)
        case .counterView(let counter, let project):
            CounterScreen(counter: counter, project: project)
        }
    }
    
    @ViewBuilder
    func sheet(for destination: SheetDestination) -> some View {
        switch destination {
        case .onboardingView:
            WelcomeScreen()
        case .newProjectView:
            NewProjectScreen()
        case .editProjectView(let project):
            EditProjectScreen(project: project)
        case .newCounterView(let project):
            NewCounterScreen(project: project)
        case .editCounterView(let counter, let project, let origin):
            EditCounterScreen(counter: counter, project: project, origin: origin)
        }
    }
    
    func push(_ destination: ScreenDestination) {
        path.append(destination)
    }
    
    func pop(route: ScreenDestination) {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheetFirst = nil
    }
    
    func presentSheet(_ sheet: SheetDestination) {
        if self.sheetFirst == nil {
            self.sheetFirst = sheet
        } else {
            self.sheetSecond = sheet
        }
    }
}


