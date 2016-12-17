// Advent Of Code
// Day 10
// http://adventofcode.com/2016/day/10

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input_test", ofType: "txt")
//let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
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

func findBotReadyToProceed(botArray: Dictionary<Int, BotInfo>) -> Int {
    for k in botArray.keys {
        if botArray[k]?.chips.count == 2 {
            return k
        }
    }

    return -1
}

func findBotWithLastComparison(botArray: Dictionary<Int, BotInfo>, i1: Int, i2: Int) -> Int {
    return -1
}

func findBotInstructions(botNumber: Int) -> [String] {
    for line in puzzleInputLineArray! {
        let arr = line.components(separatedBy: " ")
        if arr[0] == "bot" {
            let b = Int(arr[1])!
            if b == botNumber {
                return arr
            }
        }
    }

    return []
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

var part1 = findBotWithLastComparison(botArray: part1Bots, i1: 2, i2: 5)
var runaway = 0
while part1 == -1 {
    let foundBot = findBotReadyToProceed(botArray: part1Bots)
    if foundBot == -1 {
        print ("No bot was found ready to proceed!")
    }
    
    let arr = findBotInstructions(botNumber: foundBot)
    
    runaway += 1
    if runaway > 100 {
        part1 = 88888
    }
}

print (part1)
