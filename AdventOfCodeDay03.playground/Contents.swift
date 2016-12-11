// Advent Of Code
// Day 3
// http://adventofcode.com/2016/day/3

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
func validTriangle(a: Int, b: Int, c: Int) -> Bool {
    return (a + b) > c && (a + c) > b && (b + c) > a
}

var part1Ctr = 0
var part2Ctr = 0
var part2Array: [Int] = []
for part1Step in puzzleInputLineArray! {
    let arr = part1Step.condenseWhitespace().components(separatedBy: " ")
    let a = Int(arr[0])!
    let b = Int(arr[1])!
    let c = Int(arr[2])!
    if validTriangle(a: a, b: b, c: c) {
        part1Ctr += 1
    }
    part2Array.append(a)
    part2Array.append(b)
    part2Array.append(c)
    if part2Array.count == 9 {
        for i in 0...2 {
            if validTriangle(a: part2Array[i], b: part2Array[i + 3], c: part2Array[i + 6]) {
                part2Ctr += 1
            }
        }
        part2Array = []
    }
}

print (part1Ctr, terminator: "")
print (part2Ctr, terminator: "")
