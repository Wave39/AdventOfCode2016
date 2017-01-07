// Advent Of Code
// Day 16
// http://adventofcode.com/2016/day/16

// BTW: Swift string operations are SLOOOOOOOOOOOOOOOOOOOOOW !!!!!!!!!!!!!!

import Cocoa

func arrayDescription(arr: [Int]) -> String {
    var s = ""
    for i in arr {
        s += "\(i)"
    }
    
    return s
}

func createFillData(data: [Int]) -> [Int] {
    let a = data
    let b = data.reversed()
    let b1 = b.map { ($0 == 1 ? 2 : $0) }
    let b2 = b1.map { ($0 == 0 ? 1 : $0) }
    let b3 = b2.map { ($0 == 2 ? 0 : $0) }
    let c = a + [ 0 ] + b3
    return c
}

func createDiscState(initialData: [Int], size: Int) -> [Int] {
    var d = initialData
    while d.count < size {
        d = createFillData(data: d)
    }
    
    if d.count > size {
        var d2: [Int] = []
        for idx in 0..<size {
            d2.append(d[idx])
        }
        
        return d2
    }
    
    return d
}

func generateChecksum(data: [Int]) -> [Int] {
    var d = data
    var dCount = d.count
    while dCount % 2 == 0 {
        var s2: [Int]  = []
        for idx in stride(from: 0, to: dCount - 1, by: 2) {
            if d[idx] == d[idx + 1] {
                s2.append(1)
            } else {
                s2.append(0)
            }
        }
        
        d = s2
        dCount = d.count
    }
    
    return d
}

func processInput(input: [Int], length: Int) -> String {
    let discData = createDiscState(initialData: input, size: length)
    let checksum = generateChecksum(data: discData)
    return arrayDescription(arr: checksum)
}

let testInput = [ 1, 0, 0, 0, 0 ]
let testLength = 20
let testSolution = processInput(input: testInput, length: testLength)
print ("Test solution: \(testSolution)")

let part1Input = [1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0 ]
let part1Length = 272
let part1Solution = processInput(input: part1Input, length: part1Length)
print ("Part 1 solution: \(part1Solution)")

let part2Input = part1Input
let part2Length = 35651584
let part2Solution = processInput(input: part2Input, length: part2Length)
print ("Part 2 solution: \(part2Solution)")
