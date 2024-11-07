//
//  CoordinatorView.swift
//  KnitApp
//
//  Created by Vasily Pronin on 06.11.2024.
//

import SwiftUI

import SwiftUI

struct CoordinatorView<Content: View>: View {
    
    @State private var router = Coordinator()
    
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: ScreenDestination.self) {
                    router.view(for: $0)
                }
                .sheet(item: $router.sheetFirst) { destination in
                    router.sheet(for: destination)
                        .sheet(item: $router.sheetSecond) { destination in
                            router.sheet(for: destination)
                        }
                }
        }
        .environment(router)
    }
}

