//
//  PlainPreviewCell.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct PlainProjectCell: View {
    
    @State private var name: String
    @State private var isFinished: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .lineLimit(1)
            Spacer()
            Text(isFinished ? "Finished" : "In progress")
                .foregroundStyle(.gray)
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .font(.caption)
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 16)
    }
    
    init(name: String, isFinished: Bool) {
        self.name = name
        self.isFinished = isFinished
    }
}

#Preview {
    PlainProjectCell(name: "Sweater", isFinished: true)
}

