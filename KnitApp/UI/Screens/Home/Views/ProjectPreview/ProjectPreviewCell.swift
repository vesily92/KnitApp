//
//  ProjectPreviewCell.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct ProjectPreviewCell: View {
    
    @Binding var project: ProjectModel
    
    var body: some View {
        if project.isFinished {
            PlainProjectCell(name: project.name, isFinished: project.isFinished)
        } else {
            ActiveProjectCell(project: project)
        }
    }
    
    
    init(_ project: Binding<ProjectModel>) {
        self._project = project
    }
}

//#Preview {
//    ProjectPreviewCell(ProjectModel(name: "Sweater", counters: [Counter(name: "Sleeve", rowsAmount: 100, currentRow: 99)]))
//}

