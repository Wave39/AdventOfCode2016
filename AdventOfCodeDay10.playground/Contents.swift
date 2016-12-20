// Advent Of Code
// Day 10
// http://adventofcode.com/2016/day/10

import Cocoa

//let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input_test", ofType: "txt")
let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")

let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

class BotInfo : CustomStringConvertible {
    var chips: [Int]
    var lastComparison: [Int]
    init() {
        chips = []
        lastComparison = []
    }
    
    var description: String {
        return "Chips: \(chips); Last comparison: \(lastComparison)"
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
    for k in botArray.keys {
        if botArray[k]?.lastComparison.count == 2 {
            if (botArray[k]?.lastComparison[0] == i1 && botArray[k]?.lastComparison[1] == i2) || (botArray[k]?.lastComparison[0] == i2 && botArray[k]?.lastComparison[1] == i1) {
                return k
            }
        }
    }
    
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

// seed the bots with their initial chips
var part1Bots: Dictionary<Int, BotInfo> = [:]
var part1OutputBins: Dictionary<Int, BotInfo> = [:]
for line in puzzleInputLineArray! {
    let arr = line.components(separatedBy: " ")
    if arr[0] == "value" {
        let chipNumber = Int(arr[1])!
        let botNumber = Int(arr[5])!
        if part1Bots[botNumber] == nil {
            part1Bots[botNumber] = BotInfo()
        }
        
        part1Bots[botNumber]?.chips.append(chipNumber)
    }
}

func moveChipToBot(botNumber: Int, chipNumber: Int) {
    if part1Bots[botNumber] == nil {
        part1Bots[botNumber] = BotInfo()
    }
    
    let giveBot = part1Bots[botNumber]
    giveBot?.chips.append(chipNumber)
}

func moveChipToOutputBin(outputBinNumber: Int, chipNumber: Int) {
    if part1OutputBins[outputBinNumber] == nil {
        part1OutputBins[outputBinNumber] = BotInfo()
    }
    
    let bin = part1OutputBins[outputBinNumber]
    bin?.chips.append(chipNumber)
}

//let searchValues = (2, 5)
let searchValues = (61, 17)

var part1Answer = -1
var continueLooping = true
while continueLooping {
    let foundBot = findBotReadyToProceed(botArray: part1Bots)
    if foundBot == -1 {
        continueLooping = false
    } else {
        var thisBot = part1Bots[foundBot]
        let lowChipNumber = min(Int((thisBot?.chips[0])!), Int((thisBot?.chips[1])!))
        let highChipNumber = max(Int((thisBot?.chips[0])!), Int((thisBot?.chips[1])!))
        
        let arr = findBotInstructions(botNumber: foundBot)
        let lowDest = arr[5]
        let lowNumber = Int(arr[6])
        if lowDest == "bot" {
            moveChipToBot(botNumber: lowNumber!, chipNumber: lowChipNumber)
        } else if lowDest == "output" {
            moveChipToOutputBin(outputBinNumber: lowNumber!, chipNumber: lowChipNumber)
        } else {
            print ("Unknown low destination: \(lowDest)")
        }
        
        let highDest = arr[10]
        let highNumber = Int(arr[11])
        if highDest == "bot" {
            moveChipToBot(botNumber: highNumber!, chipNumber: highChipNumber)
        } else if highDest == "output" {
            moveChipToOutputBin(outputBinNumber: highNumber!, chipNumber: highChipNumber)
        } else {
            print ("Unknown high destination: \(highDest)")
        }
        
        thisBot?.chips = []
        thisBot?.lastComparison = [lowChipNumber, highChipNumber]
    }
    
    let p = findBotWithLastComparison(botArray: part1Bots, i1: searchValues.0, i2: searchValues.1)
    if p != -1 && part1Answer == -1 {
        part1Answer = p
    }
}

print (part1Answer)
print ("\((part1OutputBins[0]?.chips[0])! * (part1OutputBins[1]?.chips[0])! * (part1OutputBins[2]?.chips[0])!)")
