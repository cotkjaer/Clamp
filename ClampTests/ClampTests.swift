//
//  ClampTests.swift
//  ClampTests
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Clamp

class ClampTests: XCTestCase
{
    func test_clamp()
    {
        var integer : Int = 3
        
        integer.clamp(2, 5)
        
        XCTAssertEqual(integer, 3)
        
        integer.clamp(5, 7)
        
        XCTAssertEqual(integer, 5)
        
        integer.clamp(-10, 1)
        
        XCTAssertEqual(integer, 1)
    }
    
    func test_clamped()
    {
        let double : Double = 3
        
        XCTAssertEqual(double.clamped(2, 5), 3)
        
        XCTAssertEqual(double.clamped(5, 7), 5)
        
        XCTAssertEqual(double.clamped(-10, 1), 1)
    }
    

    func test_clamped_optionals()
    {
        var double : Double? = nil
        
        XCTAssertNil(double?.clamped())

        XCTAssertNil(double?.clamped(1, 2))

        XCTAssertNil(double?.clamped(lower: nil, upper: nil))
        
        double = 3
        
        XCTAssertEqual(double?.clamped(2, 5), 3)
        
        XCTAssertEqual(double?.clamped(5, 7), 5)
        
        XCTAssertEqual(double?.clamped(-10, 1), 1)
        
        XCTAssertEqual(double?.clamped(lower: 5), 5)

        
        XCTAssertEqual(double?.clamped(upper: 5), 3)

        var upper : Double? = 4
        var lower : Double? = 4

        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), 4)
        
        upper = 10
        lower = 5
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), lower)
        
        upper = 1
        lower = 0
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), upper)
        
        upper = nil
        lower = nil
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), double)
        
        lower = 2
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), double)
        
        lower = 4
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), lower)
        
        lower = nil
        upper = 4
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), double)
        
        upper = 2
        
        XCTAssertEqual(double?.clamped(lower: lower, upper: upper), upper)
    }
    

    func test_static_clamp()
    {
        var float : Float? = nil
        
        XCTAssertNil(clamp(float, lower: nil, upper: nil))

        XCTAssertNil(clamp(float, lower: 1, upper: nil))
        
        XCTAssertNil(clamp(float, lower: nil, upper: 1))
        
        XCTAssertNil(clamp(float, lower: 1, upper: 1))

        float = 4
        
        XCTAssertEqual(clamp(float, lower: 2, upper: 3), 3)
        
        XCTAssertEqual(clamp(float, lower: 2, upper: nil), float)

        XCTAssertEqual(clamp(float, lower: nil, upper: nil), float)
        
        XCTAssertEqual(clamp(float, lower: 5, upper: nil), 5)
        XCTAssertEqual(clamp(float, lower: nil, upper: 10), float)
    }
    
    let lowercaseLetters = Character("a")...Character("z")
    let uppercaseLetters = Character("A")...Character("Z")

    func test_range()
    {
        /// CountableClosedRange
        XCTAssertEqual(1236.clamped(3...100), 100)
        XCTAssertEqual(2.clamped(3...100), 3)
        XCTAssertEqual(55.clamped(3...100), 55)
        
        XCTAssertEqual((-100...100).clamp(2), 2)
        XCTAssertEqual((-100...100).clamp(-1022), -100)
        XCTAssertEqual((-100...100).clamp(22213), 100)
        
        // CountableRange
        XCTAssertEqual((2..<5).clamp(10), 4)
        XCTAssertEqual((2..<5).clamp(1), 2)
        XCTAssertEqual((2..<5).clamp(3), 3)
        
        XCTAssertEqual(lowercaseLetters.clamp(Character("q")), Character("q"))
        XCTAssertEqual(lowercaseLetters.clamp(Character("1")), Character("a"))
        XCTAssertEqual(uppercaseLetters.clamp(Character("a")), Character("Z"))
        
        
        //NOTE: there seems to be a bug in the way Characters are compared
        XCTAssertNotEqual(lowercaseLetters.clamp(Character("å")), Character("z"))
        
    }
}
