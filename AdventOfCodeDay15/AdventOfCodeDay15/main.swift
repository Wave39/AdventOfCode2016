// Advent Of Code
// Day 15
// http://adventofcode.com/2016/day/15

import Cocoa

struct DiscState {
    var initialPosition: Int
    var size: Int
    func positionAtTime(time: Int) -> Int {
        return (initialPosition + time) % size
    }
}

func solve(discs: [ DiscState ]) -> Int {
    var startingTime = 0
    var foundTime = -1
    while foundTime == -1 {
        var found = true
        for idx in 0..<discs.count {
            if discs[idx].positionAtTime(time: (startingTime + idx)) != 0 {
                found = false
            }
        }
        
        if found {
            foundTime = startingTime - 1
        }
        
        startingTime += 1
    }
    
    return foundTime
}

let part1Input = [ DiscState(initialPosition: 10, size: 13),
                   DiscState(initialPosition: 15, size: 17),
                   DiscState(initialPosition: 17, size: 19),
                   DiscState(initialPosition: 1, size: 7),
                   DiscState(initialPosition: 0, size: 5),
                   DiscState(initialPosition: 1, size: 3),
]
var part2Input = part1Input
part2Input.append(DiscState(initialPosition: 0, size: 11))

let part1Solution = solve(discs: part1Input)
print ("Part 1 solution: \(part1Solution)")
let part2Solution = solve(discs: part2Input)
print ("Part 2 solution: \(part2Solution)")
