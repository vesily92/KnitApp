//
//  SetupCounterViewModel.swift
//  KnitApp
//
//  Created by Vasily Pronin on 08.11.2024.
//

import Foundation
import RegexBuilder

@Observable
final class SetupCounterViewModel {
    
    var nameString: String = ""
    var currentRowString: String = ""
    var rowsAmountString: String = ""
    var rowGoalIsOn: Bool = false
    var canSubmit: Bool = false
    var showAlert: Bool = false
    
    private var project: ProjectModel
    private var counter: Counter?
    private var rowAmount: Int = 0
    
    init(project: ProjectModel, counter: Counter? = nil) {
        self.project = project
        self.counter = counter
        
        guard let counter else { return }
        
        nameString = counter.name
        currentRowString = String(counter.currentRow)
        rowGoalIsOn = counter.rowGoalIsOn
//        
        if let unwrappedAmount = counter.rowsAmount {
            rowAmount = unwrappedAmount
            rowsAmountString = String(unwrappedAmount)
        } else {
            rowAmount = 100
            rowsAmountString = "100"
        }
        
    }
    
    func trackChanges() {
        guard let counter else { return }
        
        let nameWasChanged = nameString != counter.name
        let currentRowWasChanged = currentRowString != String(counter.currentRow)
        let rowAmountWasChanged = rowsAmountString != String(rowAmount)
        let currentRowInBounds = rowAmount >= Int(currentRowString) ?? rowAmount
        let rowGoalIsOnWasChanged = rowGoalIsOn != counter.rowGoalIsOn
        
        let fieldsWereChanged = nameWasChanged
        || currentRowWasChanged
        || rowAmountWasChanged
        || rowGoalIsOnWasChanged
        
        if fieldsWereChanged {
            if rowGoalIsOn && currentRowInBounds {
                canSubmit = true
            } else if rowGoalIsOn == false {
                canSubmit = true
            } else {
                canSubmit = false
            }
        } else {
            canSubmit = false
        }
    }
    
    func createNewCounter() -> Counter {
        let name = nameString.isEmpty ? makeName() : nameString
        return Counter(name: name, currentRow: 0, rowsAmount: Int(rowsAmountString))
    }
    
    func makeUpdatedCounter() -> Counter {
        guard let counter else { fatalError("Unable to update counter.") }
        
        let name = nameString.isEmpty ? makeName() : nameString
        return Counter(
            name: name,
            currentRow: counter.currentRow,
            rowsAmount: rowGoalIsOn ? Int(rowsAmountString) : nil
        )
    }
    
    func getIndexToDelete() -> Int {
        guard let counter,
              let index = self.project.counters.firstIndex(
                where: {$0.id == counter.id }
              ) else {
            fatalError("Unable to delete counter without its ID.")
        }
        
        return index
    }
    
    
    func makeName() -> String {
        let newName = "untitled"
        let newNumber = defineNumber(for: newName)
        
        if let newNumber {
            return newName + " \(newNumber)"
        }
        
        return newName
    }
    
    private func defineNumber(for newName: String) -> Int? {
        var number: Int?
        
        var numbers: [Int] = []
        
        var check = false
        
        for counter in project.counters {
            let match = parse(name: counter.name, replacement: newName)
            if let match = match {
                let stringNumber = match.dropFirst(newName.count + 1)
                if stringNumber.isEmpty { check = true }
                
                if let newNumber = Int(stringNumber) {
                    numbers.append(newNumber)
                }
            }
        }
        if check {
            number = findMissing(in: numbers)
        } else {
            number = nil
        }
        
        return number
    }
    
    private func parse(name: String, replacement: String) -> String? {
        let pattern = Regex {
            Anchor.wordBoundary
            replacement
            ChoiceOf {
                Anchor.wordBoundary
                Regex {
                    " "
                    CharacterClass("1"..."9")
                    ZeroOrMore(.digit)
                }
            }
            Anchor.wordBoundary
        }
        
        guard let match = name.wholeMatch(of: pattern) else {
            return nil
        }
        
        return String(match.output)
    }
    
    private func findMissing(in numbers: [Int]) -> Int {
        var result = 2
        if numbers.isEmpty { return result }
        let sortedNumbers = numbers.sorted()
        for number in sortedNumbers {
            if number == result {
                result += 1
            }
        }
        return result
    }
}
