//
//  extensions.swift
//  AdventOfCodeDay16
//
//  Created by Brian Prescott on 1/6/17.
//  Copyright © 2017 Wave 39 LLC. All rights reserved.
//

import Foundation

public extension String {
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
    
    mutating func replace(index: Int, newChar: Character) {
        var chars = Array(self.characters)
        chars[index] = newChar
        self = String(chars)
    }
    
    mutating func rotate(amount: Int, left: Bool) {
        let strLen = self.length
        if left {
            for _ in 1...amount {
                let c = self[0]
                self = self.substring(from: 1) + c
            }
        } else {
            for _ in 1...amount {
                let c = self[strLen - 1]
                self = c + self.substring(to: strLen - 1)
            }
        }
    }
}

public func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
    var chars = Array(myString.characters)     // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
}
