//
//  main.swift
//  AdventOfCodeDay07
//  http://adventofcode.com/2016/day/7
//
//  Created by Brian Prescott on 12/12/16.
//  Copyright © 2016 Wave 39 LLC. All rights reserved.
//

import Cocoa

func waitForInput() -> () {
    print ("\nProgram complete, press any key to continue...")
    let keyboard = FileHandle.standardInput
    let _ = keyboard.availableData
}

let puzzleInputString = Constants.puzzleInput
let puzzleInputLineArray = puzzleInputString.components(separatedBy: "~").filter { $0.characters.count > 0 }

var part1Total = 0
for line in puzzleInputLineArray {
    var insideBrackets = false
    var hasMatchOutsideBrackets = false
    var hasMatchInsideBrackets = false
    for i in 0..<line.length - 3 {
        let chars = line[Range(i ..< i + 4)]
        if chars.characters.first == "[" {
            insideBrackets = true
        } else if chars.characters.first == "]" {
            insideBrackets = false
        } else {
            if !chars.hasBracket() && chars[0] == chars[3] && chars[1] == chars[2] && chars[0] != chars[1] {
                if insideBrackets {
                    hasMatchInsideBrackets = true
                } else {
                    hasMatchOutsideBrackets = true
                }
            }
        }
    }
    
    if hasMatchOutsideBrackets && !hasMatchInsideBrackets {
        part1Total += 1
    }
}

print (part1Total)

var part2Total = 0
for line in puzzleInputLineArray {
    var match = false
    var arr: [String] = []
    for i in 0..<line.length - 2 {
        let chars = line[Range(i ..< i + 3)]
        arr.append(chars)
    }
    
    var inside1 = false
    for i in 0..<arr.count {
        let iChars = arr[i]
        if iChars.characters.first == "[" {
            inside1 = true
        } else if iChars.characters.first == "]" {
            inside1 = false
        } else {
            if !inside1 && iChars[0] == iChars[2] && iChars[0] != iChars[1] {
                var inside2 = false
                for j in 0..<arr.count {
                    let jChars = arr[j]
                    if jChars.characters.first == "[" {
                        inside2 = true
                    } else if jChars.characters.first == "]" {
                        inside2 = false
                    } else {
                        if i != j {
                            if inside2 && jChars[0] == iChars[1] && jChars[1] == iChars[0] && jChars[2] == jChars[0] {
                                match = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (match) {
        part2Total += 1
    }
}

print (part2Total)

waitForInput()
