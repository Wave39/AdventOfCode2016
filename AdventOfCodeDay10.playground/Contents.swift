// Advent Of Code
// Day 10
// http://adventofcode.com/2016/day/10

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

struct BotInfo {
    var chips: [Int]
    var lastComparison: [Int]
    init() {
        chips = []
        lastComparison = []
    }
}

print (puzzleInputLineArray!)

// seed the bots with their initial chips
var part1Bots: Dictionary<Int, BotInfo> = [:]
for line in puzzleInputLineArray! {
    let arr = line.components(separatedBy: " ")
    if arr[0] == "value" {
        print ("found a value")
        let chipNumber = Int(arr[1])!
        let botNumber = Int(arr[5])!
        if part1Bots[botNumber] == nil {
            part1Bots[botNumber] = BotInfo()
        }
        part1Bots[botNumber]?.chips.append(chipNumber)
    }
}

print (part1Bots)
