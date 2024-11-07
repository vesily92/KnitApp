//
//  GetAppleWatchAppView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import SwiftUI

struct GetAppleWatchAppView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Get the app on your Apple Watch")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                Button("Get the app") {
                    // TODO
                }
                .buttonStyle(CustomButtonStyle(.primaryDefault()))
            }
            Spacer()
            Image("appleWatch")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                Button {
                    withAnimation {
                        isPresented.toggle()
                    }
                } label: {
                    Image(systemName: "multiply")
                        .foregroundStyle(Color.gray)
                }
                .padding(.vertical)
                Spacer()
            }
        }
        
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 112)
        .background(Color(hue: 0, saturation: 0, brightness: 0.27))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension HorizontalAlignment {
    
    struct CustomVerticalCenter: AlignmentID {
        
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    static let customVerticalCenter = HorizontalAlignment(CustomVerticalCenter.self)
}

#Preview {
    struct Preview: View {
        
        @State var isPresented: Bool = true
        
        var body: some View {
            GetAppleWatchAppView(isPresented: $isPresented)
        }
    }
    
    return Preview()
}

