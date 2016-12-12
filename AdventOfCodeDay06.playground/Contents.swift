// Advent Of Code
// Day 6
// http://adventofcode.com/2016/day/6

import Cocoa

var str = "Hello, playground"

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

var part1Array: [String] = []
for line in puzzleInputLineArray! {
    print (line)
    if part1Array.count == 0 {
        for _ in 0..<line.characters.count {
            part1Array.append("")
        }
    }
    
    var idx = 0
    for c in line.characters {
        part1Array[idx] += "\(c)"
        idx += 1
    }
}

var part1Message = ""
var part2Message = ""

for element in part1Array {
    var dict: Dictionary<Character, Int> = Dictionary()
    for c in element.characters {
        if dict[c] == nil {
            dict[c] = 1
        } else {
            dict[c] = dict[c]! + 1
        }
    }
    
    let maxValue = dict.values.max()
    let minValue = dict.values.min()
    for k in dict.keys {
        if dict[k] == maxValue {
            part1Message += "\(k)"
        }
        
        if dict[k] == minValue {
            part2Message += "\(k)"
        }
    }
}

print (part1Message, terminator: "")
print (part2Message, terminator: "")
