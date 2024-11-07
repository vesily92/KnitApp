//
//  CustomButtonStyle.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

enum ButtonConfigurationType {
    case primaryDefault(_ verticalPadding: CGFloat = 4)
    case primaryPressed
    case secondaryDefault
    case secondaryPressed
}

struct CustomButtonStyle: ButtonStyle {
    
    let configurationType: ButtonConfigurationType
    
    init(_ configurationType: ButtonConfigurationType) {
        self.configurationType = configurationType
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        switch configurationType {
        case .primaryDefault(let padding):
            configuration.label
                .font(.system(size: 15))
                .padding(.vertical, padding)
                .padding(.horizontal, 10)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        case .primaryPressed:
            configuration.label
                .font(.system(size: 15))
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        case .secondaryDefault:
            configuration.label
                .font(.system(size: 17))
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(Color.white)
                .foregroundStyle(.black)
                .clipShape(.rect(cornerRadius: 12))
        case .secondaryPressed:
            configuration.label
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(Color.white)
                .foregroundStyle(.blue)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}
