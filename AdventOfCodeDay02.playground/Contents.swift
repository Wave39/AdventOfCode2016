// Advent Of Code
// Day 2
// http://adventofcode.com/2016/day/2

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

var part1Key = 5
var part1Code = ""
for part1Step in puzzleInputLineArray! {
    for c in part1Step.characters {
        if c == "L" {
            if part1Key % 3 != 1 {
                part1Key -= 1
            }
        } else if c == "R" {
            if part1Key % 3 != 0 {
                part1Key += 1
            }
        } else if c == "U" {
            if part1Key >= 4 {
                part1Key -= 3
            }
        } else if c == "D" {
            if part1Key <= 6 {
                part1Key += 3
            }
        }
    }
    
    part1Code = part1Code + "\(part1Key)"
}

var part2Code = ""
let part2Keypad = [ ["", "", "1", "", ""], ["", "2", "3", "4", ""], ["5", "6", "7", "8", "9"], ["", "A", "B", "C", ""], ["", "", "D", "", ""] ]
var part2Key = (2, 0)
var nextKey: (Int, Int)
for part2Step in puzzleInputLineArray! {
    for c in part2Step.characters {
        nextKey = part2Key
        if c == "L" {
            if nextKey.1 > 0 {
                nextKey.1 -= 1
            }
        } else if c == "R" {
            if nextKey.1 < 4 {
                nextKey.1 += 1
            }
        } else if c == "U" {
            if nextKey.0 > 0 {
                nextKey.0 -= 1
            }
        } else if c == "D" {
            if nextKey.0 < 4 {
                nextKey.0 += 1
            }
        }
        let nextKeyChar = part2Keypad[nextKey.0][nextKey.1]
        if nextKeyChar != "" {
            part2Key = nextKey
        }
    }
    
    let nextKeyChar = part2Keypad[part2Key.0][part2Key.1]
    part2Code = part2Code + part2Keypad[part2Key.0][part2Key.1]
}

print (part1Code, terminator: "")
print (part2Code, terminator: "")
