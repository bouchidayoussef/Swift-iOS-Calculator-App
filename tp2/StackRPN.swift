//
//  StackRPN.swift
//  tp2
//
//  Created by Youssef Bouchida on 07/02/2024.
//

import Foundation

class StackRPN {
    private var myArray: [NSNumber] = []

    func push(aNumber: NSNumber) {
        myArray.append(aNumber)
    }

    func pop() -> NSNumber? {
        guard !myArray.isEmpty else { return nil }
        return myArray.removeLast()
        
    }

    func clear() {
        myArray.removeAll()
    }

    func getElementWith(aShift: Int) -> NSNumber? {
        let index = myArray.count - 1 - aShift
        guard index >= 0 && index < myArray.count else { return nil }
        return myArray[index]
    }
}
