// Advent Of Code
// Day 9
// http://adventofcode.com/2016/day/9

import Cocoa

func getStringLength(s: String, part1: Bool) -> Int {
    var theLength = 0
    var ctr = 0
    let l = s.length
    while ctr < l {
        let theChar = s[ctr]
        if theChar == "(" {
            let parenStart = ctr
            while s[ctr] != ")" {
                ctr += 1
            }
            
            let parenEnd = ctr
            let parenString = s[Range((parenStart + 1)...(parenEnd - 1))]
            let parenArr = parenString.components(separatedBy: "x")
            let charLen = Int((parenArr[0]))
            let repeatCount = Int((parenArr[1]))
            let repeatString = s[Range((parenEnd + 1)...(parenEnd + charLen!))]
            if part1 {
                theLength += repeatString.length * repeatCount!
            } else {
                theLength += getStringLength(s: repeatString, part1: false) * repeatCount!
            }
            
            ctr += (charLen! + 1)
        } else {
            theLength += 1
            ctr += 1
        }
    }
    
    return theLength
}

let puzzleInputString = Constants.puzzle_input

let part1Length = getStringLength(s: puzzleInputString, part1: true)
let part2Length = getStringLength(s: puzzleInputString, part1: false)

print (part1Length)
print (part2Length)
