//
//  ViewModel.swift
//  KnitApp
//
//  Created by Vasily Pronin on 07.11.2024.
//

import Foundation

typealias ViewModelDefinition = AnyObject & Hashable & Identifiable

protocol ViewModel: ViewModelDefinition {}

extension ViewModel {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
