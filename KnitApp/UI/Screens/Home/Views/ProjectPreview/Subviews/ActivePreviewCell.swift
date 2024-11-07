//
//  ActivePreviewCell.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct ActiveProjectCell: View {
    
    @State private var project: ProjectModel
    
    var body: some View {
        if project.withRowGoal {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(project.name)
                        .lineLimit(1)
                        .foregroundStyle(.primary)
                    VStack(alignment: .leading, spacing: 4) {
                        ProgressView(value: project.progress)
                            .progressViewStyle(ProjectProgressViewStyle())
                        Text(String(project.rowsRemain!) + " rows remains")
                            .font(.system(size: 15))
                            .foregroundStyle(.secondary)
                    }
                }
                Text(String(Int(project.progress! * 100)) + "%")
                    .frame(width: 50, alignment: .trailing)
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: 74)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            PlainProjectCell(name: project.name, isFinished: project.isFinished)
        }
    }
    
    init(project: ProjectModel) {
        self.project = project
    }
}

//#Preview {
//    ActiveProjectCell(ProjectModel(name: "Sweater", counters: [Counter(name: "Sleeve", rowsAmount: 100, currentRow: 99)]))
//}

