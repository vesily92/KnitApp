//
//  CounterPreviewCell.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct CounterPreviewCell: View {
    
    private var counter: Counter
    
    @State private var counterName: String
    @State private var rowsAmount: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(counterName)
                .foregroundStyle(.gray)
                .padding(.top, 12)
            HStack(spacing: 0) {
                Text(String(counter.currentRow))
                if !rowsAmount.isEmpty {
                    Text("/" + rowsAmount)
                        .foregroundStyle(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .font(.largeTitle)
            .fontWeight(.bold)
            Spacer()
        }
    }
    
    init(counter: Counter) {
        self.counter = counter
        
        counterName = counter.name ?? ""
        
        if let unwrappedAmount = counter.rowsAmount {
            rowsAmount = String(unwrappedAmount)
        } else {
            rowsAmount = ""
        }
    }
}

//#Preview {
//    CounterPreviewCell(counter: Counter(name: "Sleeve", rowsAmount: 100, currentRow: 99))
//}
