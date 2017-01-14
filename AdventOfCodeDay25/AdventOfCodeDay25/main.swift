// Advent Of Code
// Day 25 (!!!)
// http://adventofcode.com/2016/day/25

import Foundation

enum Opcode {
    case cpy
    case inc
    case dec
    case jnz
    case out
}

struct Param {
    var numericValue: Int?
    var registerIndex: Int?
}

struct Instruction {
    var opcode: Opcode
    var param1: Param
    var param2: Param?
}

func isStringNumeric(theString: String) -> Bool {
    if !theString.isEmpty {
        var numberCharacters = NSCharacterSet.decimalDigits.inverted
        numberCharacters.remove(charactersIn: "-")
        return !theString.isEmpty && theString.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    return false
}

func getParamValue(p: Param, registers: [Int]) -> Int {
    var v: Int
    if p.numericValue != nil {
        v = p.numericValue!
    } else {
        v = registers[p.registerIndex!]
    }
    
    return v
}

func processInstructionsFaster(instructionArray: [Instruction], registerToRetrieve: Int, registers: [Int]) -> [Int] {
    var instructionArray = instructionArray
    var registers = registers
    var programCounter = 0
    var leaveLoop = false
    var outputArray: [Int] = []
    
    while programCounter < instructionArray.count && leaveLoop == false {
        let instruction = instructionArray[programCounter]
        if instruction.opcode == .cpy {
            let p1 = instruction.param1
            let p2 = instruction.param2!
            if p2.registerIndex != nil {
                let value = getParamValue(p: p1, registers: registers)
                registers[p2.registerIndex!] = value
            }
            
            programCounter += 1
        } else if instruction.opcode == .inc {
            let p1 = instruction.param1
            let registerValue = registers[p1.registerIndex!]
            registers[p1.registerIndex!] = registerValue + 1
            programCounter += 1
        } else if instruction.opcode == .dec {
            let p1 = instruction.param1
            let registerValue = registers[p1.registerIndex!]
            registers[p1.registerIndex!] = registerValue - 1
            programCounter += 1
        } else if instruction.opcode == .jnz {
            let p1 = instruction.param1
            let p1Value = getParamValue(p: p1, registers: registers)
            if p1Value != 0 {
                let p2 = instruction.param2!
                let p2Value = getParamValue(p: p2, registers: registers)
                programCounter += p2Value
            } else {
                programCounter += 1
            }
        } else if instruction.opcode == .out {
            let p1 = instruction.param1
            let p1Value = getParamValue(p: p1, registers: registers)
            outputArray.append(p1Value)
            if outputArray.count >= 100 {
                leaveLoop = true
            }
            
            programCounter += 1
        } else {
            print ("Unknown instruction: \(instruction)")
            programCounter += 1
        }
    }
    
    return outputArray
}

func buildParam(inputString: String) -> Param? {
    var p: Param? = nil
    if isStringNumeric(theString: inputString) {
        p = Param(numericValue: Int(inputString)!, registerIndex: nil)
    } else {
        let idx: Int
        if inputString == "a" {
            idx = 0
        } else if inputString == "b" {
            idx = 1
        } else if inputString == "c" {
            idx = 2
        } else {
            idx = 3
        }
        
        p = Param(numericValue: nil, registerIndex: idx)
    }
    
    return p
}

func buildInstructionSet(lineArray: [String]) -> [Instruction] {
    var instructionSet: [Instruction] = []
    
    for line in lineArray {
        let c = line.components(separatedBy: " ")
        let op: Opcode?
        var p1: Param? = nil
        var p2: Param? = nil
        if c[0] == "cpy" {
            op = .cpy
        } else if c[0] == "inc" {
            op = .inc
        } else if c[0] == "dec" {
            op = .dec
        } else if c[0] == "jnz" {
            op = .jnz
        } else {
            op = .out
        }
        
        p1 = buildParam(inputString: c[1])
        
        if c.count >= 3 {
            p2 = buildParam(inputString: c[2])
        }
        
        let newInstruction = Instruction(opcode: op!, param1: p1!, param2: p2)
        instructionSet.append(newInstruction)
    }
    
    return instructionSet
}

let part1 = puzzleInput.components(separatedBy: "~").filter { $0.characters.count > 0 }
let part1InstructionSet = buildInstructionSet(lineArray: part1)
var counter = 0
var part1Solution = -1
while part1Solution == -1 {
    let registerArray = [ counter, 0, 0, 0 ]
    let output = processInstructionsFaster(instructionArray: part1InstructionSet, registerToRetrieve: 0, registers: registerArray)
    let n0 = output[0]
    let n1 = output[1]
    if n0 != n1 {
        var ok = true
        for idx in stride(from: 0, through: (output.count - 1), by: 2) {
            if output[idx] != n0 || output[idx + 1] != n1 {
                ok = false
            }
        }
        
        if ok {
            part1Solution = counter
        }
    }
    
    counter += 1
}

print ("Part 1 solution: \(part1Solution)")
