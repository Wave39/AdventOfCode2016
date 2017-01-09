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

let part1ElfCount = 3004953
let part1Solution = findPart1Solution(elfCount: part1ElfCount)
print ("Part 1 solution: \(part1Solution)")
