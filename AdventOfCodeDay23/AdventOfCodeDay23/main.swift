// Advent Of Code
// Day 23
// http://adventofcode.com/2016/day/23

import Foundation

enum Opcode {
    case cpy
    case inc
    case dec
    case jnz
    case tgl
    case mul
}

struct Param {
    var numericValue: Int?
    var registerIndex: Int?
}

struct Instruction {
    var opcode: Opcode
    var param1: Param
    var param2: Param?
    var param3: Param?
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

func processInstructionsFaster(instructionArray: [Instruction], registerToRetrieve: Int, registers: [Int]) -> Int {
    var instructionArray = instructionArray
    var registers = registers
    var programCounter = 0
    while programCounter < instructionArray.count {
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
        } else if instruction.opcode == .tgl {
            let p1 = instruction.param1
            let p1Value = getParamValue(p: p1, registers: registers)
            let programCounterToModify = programCounter + p1Value
            if programCounterToModify >= 0 && programCounterToModify < instructionArray.count {
                var instructionToModify = instructionArray[programCounterToModify]
                if instructionToModify.param2 == nil {
                    if instructionToModify.opcode == .inc {
                        instructionToModify.opcode = .dec
                    } else {
                        instructionToModify.opcode = .inc
                    }
                } else {
                    if instructionToModify.opcode == .jnz {
                        instructionToModify.opcode = .cpy
                    } else {
                        instructionToModify.opcode = .jnz
                    }
                }
                
                instructionArray[programCounterToModify] = instructionToModify
            }
            
            programCounter += 1
        } else if instruction.opcode == .mul {
            let p1 = instruction.param1
            let p1Value = getParamValue(p: p1, registers: registers)
            let p2 = instruction.param2!
            let p2Value = getParamValue(p: p2, registers: registers)
            let p3 = instruction.param3!
            registers[p3.registerIndex!] = p1Value * p2Value
            programCounter += 1
        } else {
            print ("Unknown instruction: \(instruction)")
            programCounter += 1
        }
    }
    
    return registers[registerToRetrieve]
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
        var p3: Param? = nil
        if c[0] == "cpy" {
            op = .cpy
        } else if c[0] == "inc" {
            op = .inc
        } else if c[0] == "dec" {
            op = .dec
        } else if c[0] == "jnz" {
            op = .jnz
        } else if c[0] == "mul" {
            op = .mul
        } else {
            op = .tgl
        }
        
        p1 = buildParam(inputString: c[1])
        
        if c.count >= 3 {
            p2 = buildParam(inputString: c[2])
        }
        
        if c.count >= 4 {
            p3 = buildParam(inputString: c[3])
        }
        
        let newInstruction = Instruction(opcode: op!, param1: p1!, param2: p2, param3: p3)
        instructionSet.append(newInstruction)
    }
    
    return instructionSet
}

let part1 = puzzleInputOptimized.components(separatedBy: "~").filter { $0.characters.count > 0 }
let part1InstructionSet = buildInstructionSet(lineArray: part1)
let part1RegisterArray = [ 7, 0, 0, 0 ]
let part1Solution = processInstructionsFaster(instructionArray: part1InstructionSet, registerToRetrieve: 0, registers: part1RegisterArray)
print ("Part 1 solution: \(part1Solution)")

let part2 = puzzleInputOptimized.components(separatedBy: "~").filter { $0.characters.count > 0 }
let part2InstructionSet = buildInstructionSet(lineArray: part2)
let part2RegisterArray = [ 12, 0, 0, 0 ]
let part2Solution = processInstructionsFaster(instructionArray: part2InstructionSet, registerToRetrieve: 0, registers: part2RegisterArray)
print ("Part 2 solution: \(part2Solution)")
