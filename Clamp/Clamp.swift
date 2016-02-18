//
//  Clamp.swift
//  Silverback
//
//  Created by Christian Otkjær on 16/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

// MARK: - Comparable

public func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T
{
    return value.clamped(lower, upper)
}

public extension Comparable
{
    func clamped(lower: Self, _ upper: Self) -> Self
    {
        guard upper >= lower else { return self }
        
        if self > upper { return upper }
        if self < lower { return lower }
        return self
//        return min(max(self, lower), upper)
    }
    
    mutating func clamp(lower: Self, _ upper: Self)
    {
        self = clamped(lower, upper)
    }
}

// MARK: - ForwardIndexType

extension ForwardIndexType where Self : Comparable
{
    /**
     Clamps self to a specified range.
     
     - parameter range: Clamping range
     - returns: Clamped value
     */
    func clamped(range: Range<Self>?) -> Self
    {
        if let range = range
        {
            return clamped(range.startIndex, range.endIndex.advancedBy(-1))
        }
        
        return self
    }

    mutating func clamp(range: Range<Self>?)
    {
        self = clamped(range)
    }
}

// MARK: - Range

extension Range where Element : Comparable
{
    public func clamp(index: Element?) -> Element?
    {
        return index?.clamped(self)
    }
}

public func clamp<T: Comparable>(value: T?, range: Range<T>?) -> T?
{
    return value?.clamped(range)//range.startIndex, range.endIndex.advancedBy(-1))
}
