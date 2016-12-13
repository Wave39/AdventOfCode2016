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
    for idx in 0..<line.length - 3 {
        let chars = line[Range(idx ..< idx + 4)]
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

waitForInput()
