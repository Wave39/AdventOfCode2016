// Advent Of Code
// Day 16
// http://adventofcode.com/2016/day/16

import Cocoa

func createFillString(str: String) -> String {
    let a = str
    let b = String(str.characters.reversed())
    let b1 = b.replacingOccurrences(of: "1", with: "2")
    let b2 = b1.replacingOccurrences(of: "0", with: "1")
    let b3 = b2.replacingOccurrences(of: "2", with: "0")
    let c = a + "0" + b3
    print (c.characters.count)
    return c
}

func createDiscState(initialString: String, size: Int) -> String {
    var s = initialString
    while s.characters.count < size {
        s = createFillString(str: s)
    }
    
    return s.substring(to: size)
}

func generateChecksum(str: String) -> String {
    var s = str
    var sLength = s.length
    while sLength % 2 == 0 {
        var s2 = ""
        for idx in stride(from: 0, to: sLength - 1, by: 2) {
            if s[idx] == s[idx + 1] {
                s2 += "1"
            } else {
                s2 += "0"
            }
        }
        
        s = s2
        sLength = s.length
    }
    
    return s
}

func processInput(input: String, length: Int) -> String {
    let discData = createDiscState(initialString: input, size: length)
    return generateChecksum(str: discData)
}

//let part1Input = "10000"
//let part1Length = 20
let part1Input = "10001110011110000"
let part1Length = 272
let part1Solution = processInput(input: part1Input, length: part1Length)
print ("Part 1 solution: \(part1Solution)")

let part2Input = part1Input
let part2Length = 35651584
let part2Solution = processInput(input: part2Input, length: part2Length)
print ("Part 2 solution: \(part2Solution)")
