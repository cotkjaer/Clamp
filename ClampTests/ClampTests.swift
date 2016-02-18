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
    
    func test_static_clamp()
    {
        let float : Float = 4
        
        XCTAssertEqual(clamp(float, lower: 2, upper: 3), 3)
        
        XCTAssertEqual(clamp(float, lower: 5, upper: 10), 5)
    }
    
    func test_range()
    {
        XCTAssertEqual(5.clamped(3...4), 4)
        XCTAssertEqual(2.clamped(3...4), 3)
        
        let clamped = (3...4).clamp(2)
        
        XCTAssertEqual(clamped, 3)
    }
}
