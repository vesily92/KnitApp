//
//  CustomTextField.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct CustomTextField: View {
    
    enum InputType {
        case string
        case numeric
    }
    
    @Binding var text: String
    
    var title: String
    var inputType: InputType = .string
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 100, alignment: .leading)
                .font(.body)
            switch inputType {
            case .string:
                makeStringTextField()
                    .frame(maxWidth: .infinity)
                    .font(.body)
            case .numeric:
                makeNumericTextField()
                    .frame(maxWidth: .infinity)
                    .font(.body)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    private func makeStringTextField() -> some View {
        TextField(title, text: $text)
    }
    
    private func makeNumericTextField() -> some View {
        TextField(title, text: $text.onChange { input in
            let filtered = input.filter { "0123456789".contains($0) }
            if filtered != input {
                self.text = filtered
            }
        })
    }
}

//#Preview {
//    CustomTextField()
//}

