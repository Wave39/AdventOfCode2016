// Advent Of Code
// Day 12
// http://adventofcode.com/2016/day/12

import Cocoa

func isStringNumeric(theString: String) -> Bool {
    if !theString.isEmpty {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !theString.isEmpty && theString.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    return false
}

func processInstructions(arr: [String], registerToRetrieve: String, registers: Dictionary<String, Int>) -> Int {
    var registers = registers
    var programCounter = 0
    while programCounter < arr.count {
        let line = arr[programCounter]
        let arr = line.components(separatedBy: " ")
        if arr[0] == "cpy" {
            let reg = arr[2]
            var registerValue: Int
            if isStringNumeric(theString: arr[1]) {
                registerValue = Int(arr[1])!
            } else {
                registerValue = registers[arr[1]]!
            }
            
            registers[reg] = registerValue
            programCounter += 1
        } else if arr[0] == "inc" {
            let reg = arr[1]
            let registerValue = registers[reg]!
            registers[reg] = registerValue + 1
            programCounter += 1
        } else if arr[0] == "dec" {
            let reg = arr[1]
            let registerValue = registers[reg]!
            registers[reg] = registerValue - 1
            programCounter += 1
        } else if arr[0] == "jnz" {
            let reg = arr[1]
            var registerValue: Int
            if isStringNumeric(theString: reg) {
                registerValue = Int(reg)!
            } else {
                registerValue = registers[reg]!
            }
            
            if registerValue != 0 {
                programCounter += Int(arr[2])!
            } else {
                programCounter += 1
            }
        } else {
            print ("Unknown command: \(arr[0])")
        }
    }
    
    return registers[registerToRetrieve]!
}

let test = puzzleInputTest.components(separatedBy: "~").filter { $0.characters.count > 0 }
let testRegisters = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
let testSolution = processInstructions(arr: test, registerToRetrieve: "a", registers: testRegisters)
print ("Test solution: \(testSolution)")

let part1 = puzzleInput.components(separatedBy: "~").filter { $0.characters.count > 0 }
let part1Registers = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
let part1Solution = processInstructions(arr: part1, registerToRetrieve: "a", registers: part1Registers)
print ("Part 1 solution: \(part1Solution)")

let part2 = puzzleInput.components(separatedBy: "~").filter { $0.characters.count > 0 }
let part2Registers = [ "a": 0, "b": 0, "c": 1, "d": 0 ]
let part2Solution = processInstructions(arr: part2, registerToRetrieve: "a", registers: part2Registers)
print ("Part 2 solution: \(part2Solution)")
