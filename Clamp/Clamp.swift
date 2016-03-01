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
@warn_unused_result
public func clamp<T: Comparable>(value: T?, lower: T? = nil, upper: T? = nil) -> T?
{
    return value?.clamped(lower: lower, upper: upper)
}

/**
 `value` clamped to a given range.
 
 - parameter value: (optional) value to be clamped
 - parameter range: the range to clamp to
 
 - returns: `value` clamped to the given range; `[lower;upper]`
 */
@warn_unused_result
public func clamp<T: Comparable>(value: T?, range: Range<T>?) -> T?
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
    @warn_unused_result
    func clamped(lower: Self, _ upper: Self) -> Self
    {
        guard upper >= lower else { return self }
        
        if self > upper { return upper }
        
        if self < lower { return lower }
        
        return self
    }
    
    func clamped(lower lower: Self? = nil, upper: Self? = nil) -> Self
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
    mutating func clamp(lower: Self, _ upper: Self)
    {
        self = clamped(lower, upper)
    }
}

// MARK: - ForwardIndexType

extension ForwardIndexType where Self : Comparable
{
    /**
     `self` clamped to a given range.
     
     - parameter range: (optional) clamping range
     
     - returns: `self` clamped to the given range; `[startIndex;endIndex[` or `self` if range is `nil`
     */
    func clamped(range: Range<Self>?) -> Self
    {
        if let range = range
        {
            return clamped(range.startIndex, range.endIndex.advancedBy(-1))
        }
        
        return self
    }

    /**
     Clamps `self` to a specified range; `[startIndex;endIndex[`
     
     - parameter range: (optional) clamping range
     */
    mutating func clamp(range: Range<Self>?)
    {
        self = clamped(range)
    }
}

// MARK: - Range

extension Range where Element : Comparable
{
    /**
     Clamps `index` to `self`; `[startIndex;endIndex[`
     
     - parameter index: (optional) index to be clamped
     
     - returns: an index that is within `self`
     */
    @warn_unused_result
    public func clamp(index: Element?) -> Element?
    {
        return index?.clamped(self)
    }
}

