//
//  ProjectZeroStateView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct ProjectZeroStateView: View {
    
    @Binding var project: ProjectModel
    
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("No counters yet")
                Text("Start by creating a new one to keep track of your knitting progress")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 60)
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("New counter")
                }
            }
            .buttonStyle(CustomButtonStyle(.primaryDefault(7)))
        }
        .navigationTitle(project.name)
        .toolbar {
            Button("Edit") {
                
            }
        }
    }
}

//#Preview {
//    ProjectZeroStateView()
//}
