//
//  ProjectProgressViewStyle.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct ProjectProgressViewStyle: ProgressViewStyle {
    var height: Double = 6
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { proxy in
            Capsule()
                .frame(height: height)
                .frame(width: proxy.size.width)
                .foregroundStyle(.background.secondary)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: height)
                        .frame(height: height)
                        .frame(width: max(height, proxy.size.width * progress))
                        .foregroundStyle(Color.purple)
                }
        }
    }
}
