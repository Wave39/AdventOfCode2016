// Advent Of Code
// Day 20
// http://adventofcode.com/2016/day/20

import Foundation

func findSolution(addressPairArray: [(Int, Int)], startingAt: Int) -> Int {
    if startingAt > 4294967295 {
        return -1
    }

    var addressPointer = startingAt
    while true {
        var addressFound = false
        for pair in addressPairArray {
            if addressPointer >= pair.0 && addressPointer <= pair.1 {
                addressFound = true
                addressPointer = pair.1 + 1
                continue
            }
        }
        
        if addressPointer > 4294967295 && !addressFound {
            return -1
        }
        
        if !addressFound {
            return addressPointer
        }
    }
}

let lineArray = puzzleInput.components(separatedBy: "~")
var part1Array: [(Int, Int)] = []
for line in lineArray {
    let arr = line.components(separatedBy: "-")
    let lowerBound = Int(arr[0])!
    let upperBound = Int(arr[1])!
    let pair = (lowerBound, upperBound)
    part1Array.append(pair)
}

let part1Solution = findSolution(addressPairArray: part1Array, startingAt: 0)
print ("Part 1 solution: \(part1Solution)")

var part2Solution = 0
var part2Position = findSolution(addressPairArray: part1Array, startingAt: 0)
while part2Position != -1 {
    part2Solution += 1
    part2Position = findSolution(addressPairArray: part1Array, startingAt: part2Position + 1)
}

print ("Part 2 solution: \(part2Solution)")
