//
//  tp2Tests.swift
//  tp2Tests
//
//  Created by Youssef Bouchida on 07/02/2024.
//
import XCTest
@testable import tp2

class StackRPNTests: XCTestCase {
    
    var stack: StackRPN!
    
    override func setUp() {
        super.setUp()
        stack = StackRPN()
    }
    
    override func tearDown() {
        stack = nil
        super.tearDown()
    }
    
    func testPushAndPop() {
        stack.push(NSNumber(value: 1))
        stack.push(NSNumber(value: 2))
        let poppedValue = stack.pop()
        
        XCTAssertEqual(poppedValue, NSNumber(value: 2), "La valeur dépilée doit être 2")
    }
    
    func testClear() {
        stack.push(NSNumber(value: 1))
        stack.clear()
        let element = stack.pop()
        
        XCTAssertNil(element, "La pile doit être vide après l'appel de clear")
    }
    
    
}
