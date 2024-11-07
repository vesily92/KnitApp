//
//  ProjectScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct ProjectScreen: View {
    
    @Binding var project: ProjectModel
    
    var body: some View {
        if project.counters.isEmpty {
            ProjectZeroStateView(project: $project)
        } else {
            ProjectView(project: $project)
        }
    }
}
