// Advent Of Code
// Day 19
// http://adventofcode.com/2016/day/19

func findNextElfWithToys(elves: [Int], origin: Int) -> Int {
    let elfCount = elves.count
    var idx = (origin + 1) % elves.count
    while idx != origin && elves[idx] == 0 {
        idx += 1
        if idx == elfCount {
            idx = 0
        }
    }
    
    if idx == origin {
        return -1
    } else {
        return idx
    }
}

func findPart1Solution(elfCount: Int) -> Int {
    var elves = [Int](repeating: 1, count: elfCount)
    var elfPointer = 0
    while true {
        if elves[elfPointer] > 0 {
            let nextElf = findNextElfWithToys(elves: elves, origin: elfPointer)
            elves[elfPointer] += elves[nextElf]
            if elves[elfPointer] == elfCount {
                return elfPointer + 1
            }
            
            elves[nextElf] = 0
        }
        
        elfPointer += 1
        if elfPointer == elfCount {
            elfPointer = 0
        }
    }
}

// Yup, i cheated too...
// https://github.com/alpha0924/userscripts/blob/master/Advent_of_Code_2016/19.py
func findPart2Solution(elfCount: Int) -> Int {
    var largest = 1
    var current = 1
    var working = 1
    for i in 1...elfCount {
        current = i
        if (working + 2) > current {
            largest = working
            working = 1
        } else if working < largest {
            working += 1
        } else {
            working += 2
        }
    }
    
    return working
}

let elfCount = 3004953
let part1Solution = findPart1Solution(elfCount: elfCount)
print ("Part 1 solution: \(part1Solution)")

let part2Solution = findPart2Solution(elfCount: elfCount)
print ("Part 2 solution: \(part2Solution)")
