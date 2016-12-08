// Advent Of Code
// Day 1
// http://adventofcode.com/2016/day/1

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: ",")

func parseStep(step: String) -> (String, Int?) {
    let trimString = step.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\n", with: "")
    let direction = trimString.substring(to: step.index(step.startIndex, offsetBy: 1))
    let amount = trimString.substring(from: step.index(step.startIndex, offsetBy: 1))
    let amountInt = Int(amount)
    return (direction, amountInt)
}

enum Direction: Int {
    case North = 0
    case East = 1
    case South = 2
    case West = 3
    
    func nextHeading(turnTo: String) -> Direction {
        var newDirection: Int
        if turnTo == "R" {
            newDirection = self.rawValue + 1
            if newDirection > Direction.West.rawValue {
                newDirection = Direction.North.rawValue
            }
        } else {
            newDirection = self.rawValue - 1
            if newDirection < Direction.North.rawValue {
                newDirection = Direction.West.rawValue
            }
        }
        
        return Direction(rawValue: newDirection)!
    }
}

var currentHeading = Direction.North
var currentNSPosition = 0
var currentWEPosition = 0
var locationsVisited = Set<(String)>()
var part2NSPosition = 0
var part2WEPosition = 0
var part2HeadquartersFound = false

for oneStep in puzzleInputLineArray! {
    print (oneStep)
    let s = parseStep(step: oneStep)
    currentHeading = currentHeading.nextHeading(turnTo: s.0)
    var travelAmount: Int = s.1!
    let inc = (currentHeading == .South || currentHeading == .West) ? -1 : 1
    
    for _ in 0..<travelAmount {
        if currentHeading == .North || currentHeading == .South {
            currentNSPosition += inc
        } else {
            currentWEPosition += inc
        }

        let currentLocationString = "\(currentNSPosition),\(currentWEPosition)"
        if locationsVisited.contains(currentLocationString) && !part2HeadquartersFound {
            part2HeadquartersFound = true
            part2NSPosition = currentNSPosition
            part2WEPosition = currentWEPosition
        } else {
            locationsVisited.insert(currentLocationString)
        }
    }
}

let part1Answer = Swift.abs(currentNSPosition) + Swift.abs(currentWEPosition)
let part2Answer = Swift.abs(part2NSPosition) + Swift.abs(part2WEPosition)
