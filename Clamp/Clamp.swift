//
//  Clamp.swift
//  Silverback
//
//  Created by Christian Otkjær on 16/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

// MARK: - Comparable

/**
 `value` clamped to a given range.
 
 - parameter value: (optional) value to be clamped
 - parameter lower: minimum value
 - parameter upper: maximum value
 
 - returns: `value` clamped to the given range; `[lower;upper]`
 */
public func clamp<T: Comparable>(_ value: T?, lower: T? = nil, upper: T? = nil) -> T?
{
    return value?.clamped(lower: lower, upper: upper)
}

/**
 `value` clamped to a given range.
 
 - parameter value: (optional) value to be clamped
 - parameter range: the range to clamp to
 
 - returns: `value` clamped to the given range; `[lower;upper]`
 */
public func clamp<T: Comparable>(_ value: T?, range: ClosedRange<T>?) -> T?
{
    return value?.clamped(range)
}


public extension Comparable
{
    /**
     `self` clamped to a given range.
     
     - parameter lower: minimum value
     - parameter upper: maximum value
     
     - returns: `self` clamped to the given range; `[lower;upper]`
     */
    
    func clamped(_ lower: Self, _ upper: Self) -> Self
    {
        guard upper >= lower else { return self }
        
        if self > upper { return upper }
        
        if self < lower { return lower }
        
        return self
    }
    
    func clamped(lower: Self? = nil, upper: Self? = nil) -> Self
    {
        if let upper = upper
        {
            if self > upper { return upper }
        }
        
        if let lower = lower
        {
            if self < lower { return lower }
        }
        
        return self
    }
    
    /**
     Clamps `self` to a given range; `[lower;upper]`
     
     - parameter lower: minimum value
     - parameter upper: maximum value
     */
    mutating func clamp(_ lower: Self, _ upper: Self)
    {
        self = clamped(lower, upper)
    }
    
    // MARK: - Ranges
    
    /**
     `self` clamped to a given range.
     
     - parameter range: (optional) clamping range
     
     - returns: `self` clamped to the given range; `[lowerBound;upperBound]` or `self` if range is `nil`
     */
    func clamped(_ range: ClosedRange<Self>?) -> Self
    {
        guard let range = range else { return self }
        
        return clamped(range.lowerBound, range.upperBound)
    }
    
    /**
     Clamps `self` to a specified range; `[lowerBound;upperBound[`
     
     - parameter range: (optional) clamping range
     */
    mutating func clamp(_ range: ClosedRange<Self>?)
    {
        self = clamped(range)
    }
}

// MARK: - <#comment#>

extension Strideable where Self.Stride: SignedInteger
{
    /**
     `self` clamped to a given range.
     
     - parameter range: (optional) clamping range
     
     - returns: `self` clamped to the given range; `[lowerBound;upperBound[` or `self` if range is `nil`
     */
    func clamped(_ range: CountableClosedRange<Self>?) -> Self
    {
        guard let range = range else { return self }
        
        return clamped(range.lowerBound, range.upperBound)
    }
    
    /**
     `self` clamped to a given range.
     
     - parameter range: (optional) clamping range
     
     - returns: `self` clamped to the given range; `[lowerBound;upperBound[` or `self` if range is `nil`
     */
    func clamped(_ range: CountableRange<Self>?) -> Self
    {
        guard let range = range else { return self }
        
        let closedRange = CountableClosedRange(range)
        
        return clamped(closedRange)
        
        //        return clamped(range.lowerBound, range.upperBound.advanced(by: -1))
    }
    
    /**
     Clamps `self` to a specified range; `[lowerBound;upperBound[`
     
     - parameter range: (optional) clamping range
     */
    mutating func clamp(_ range: CountableRange<Self>?)
    {
        self = clamped(range)
    }
    
}


// MARK: - <#comment#>

extension CountableRange
{
    /**
     Clamps `element` to `self`; `[lowerBound;upperBound[`
     
     - parameter element: (optional) index to be clamped
     
     - returns: an element that is within `self`
     */
    func clamp(_ e: Element?) -> Element?
    {
        return e?.clamped(lowerBound, upperBound.advanced(by:-1))
    }
}


extension CountableClosedRange
{
    /**
     Clamps `element` to `self`; `[lowerBound;upperBound]`
     
     - parameter element: (optional) index to be clamped
     
     - returns: an element that is within `self`
     */
    func clamp(_ element: Element?) -> Element?
    {
        return element?.clamped(lowerBound, upperBound)
    }
}

// MARK: - Range

extension ClosedRange where Bound : Comparable
{
    /**
     Clamps `element` to `self`; `[lowerBound;upperBound]`
     
     - parameter element: (optional) index to be clamped
     
     - returns: an element that is within `self`
     */
    public func clamp(_ element: Bound?) -> Bound?
    {
        return element?.clamped(self)
    }
}

