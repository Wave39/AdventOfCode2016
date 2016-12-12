//
//  main.swift
//  AdventOfCodeDay05
//
//  Created by Brian Prescott on 12/11/16.
//  Copyright © 2016 Wave 39 LLC. All rights reserved.
//
// http://adventofcode.com/2016/day/5
//

import Foundation

extension String {
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
}

func MD5(string: String) -> Data? {
    guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    
    _ = digestData.withUnsafeMutableBytes {digestBytes in
        messageData.withUnsafeBytes {messageBytes in
            CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
        }
    }
    
    return digestData
}

func MD5String(string: String) -> String {
    let data = MD5(string: string)
    return data!.map { String(format: "%02hhx", $0) }.joined()
}

func replace(myString: String, index: Int, newChar: Character) -> String {
    var chars = Array(myString.characters)     // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
}

var part1Password = ""
var part2Password = "--------"
var idx = 0
let part1Prefix = "wtnhxymk"
while part1Password.length < 8 || part2Password.contains("-") {
    let md5String = MD5String(string: "\(part1Prefix)\(idx)")
    if md5String.hasPrefix("00000") {
        print ("On index \(idx) the MD5 hash is \(md5String)")
        let sixthChar = md5String[5]
        if part1Password.length < 8 {
            part1Password += "\(sixthChar)"
            print ("Part 1 password becomes \(part1Password)")
        }
        
        if sixthChar >= "0" && sixthChar <= "7" {
            let pos = Int(sixthChar)
            if part2Password[pos!] == "-" {
                let seventhChar = md5String[6].characters.first
                part2Password = replace(myString: part2Password, index: pos!, newChar: seventhChar!)
                print ("Part 2 password becomes \(part2Password)")
            }
        }
    }
    
    idx += 1
    if idx % 100000 == 0 {
        print (idx)
    }
}

print (part1Password)
print (part2Password)
