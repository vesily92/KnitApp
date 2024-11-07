//
//  WelcomeScreen.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @Environment(Coordinator.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Welcome to Knit app!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 190)
                .multilineTextAlignment(.center)
                .padding(.vertical, 60)
            
            featureView(
                title: "Sync Rows & Projects",
                message: "Create row counters, manage projects, and sync across devices.",
                image: "square.grid.2x2.fill"
            )
            .padding(.horizontal, 32)
            .padding(.vertical)
            featureView(
                title: "Apple Watch Counters",
                message: "Track rows on your Apple Watch with automatic syncing.",
                image: "applewatch.radiowaves.left.and.right"
            )
            .padding(.horizontal, 32)
            .padding(.vertical)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("New project")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 24)
            .padding(.bottom, 52)
        }
        .presentationDragIndicator(.visible)
    }
    
    private func featureView(title: String, message: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 40)
                .padding()
                .foregroundStyle(.blue)
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                Text(message)
                    .font(.callout)
                    .foregroundStyle(Color.secondary)
            }
            Spacer()
        }
        .frame(maxHeight: 65)
    }
}

#Preview {
    WelcomeScreen()
}

