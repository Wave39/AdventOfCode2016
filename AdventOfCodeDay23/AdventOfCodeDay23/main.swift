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

func processInstructions(instructionArray: [String], registerToRetrieve: String, registers: Dictionary<String, Int>, displayRegisters: Bool) -> Int {
    var instructionArray = instructionArray
    var registers = registers
    var programCounter = 0
    var ctr = 0
    while programCounter < instructionArray.count {
        if displayRegisters {
            ctr += 1
            if ctr % 100 == 0 {
                print ("Registers: \(registers)")
            }
        }
        
        let line = instructionArray[programCounter]
        let componentArray = line.components(separatedBy: " ")
        if componentArray[0] == "cpy" {
            let reg = componentArray[2]
            if !isStringNumeric(theString: reg) {
                var registerValue: Int
                if isStringNumeric(theString: componentArray[1]) {
                    registerValue = Int(componentArray[1])!
                } else {
                    registerValue = registers[componentArray[1]]!
                }
                
                registers[reg] = registerValue
            }
            programCounter += 1
        } else if componentArray[0] == "inc" {
            let reg = componentArray[1]
            let registerValue = registers[reg]!
            registers[reg] = registerValue + 1
            programCounter += 1
        } else if componentArray[0] == "dec" {
            let reg = componentArray[1]
            let registerValue = registers[reg]!
            registers[reg] = registerValue - 1
            programCounter += 1
        } else if componentArray[0] == "jnz" {
            let reg = componentArray[1]
            var registerValue: Int
            if isStringNumeric(theString: reg) {
                registerValue = Int(reg)!
            } else {
                registerValue = registers[reg]!
            }
            
            if registerValue != 0 {
                let reg2 = componentArray[2]
                var reg2Value: Int
                if isStringNumeric(theString: reg2) {
                    reg2Value = Int(reg2)!
                } else {
                    reg2Value = registers[reg2]!
                }
                
                programCounter += reg2Value
            } else {
                programCounter += 1
            }
        } else if componentArray[0] == "tgl" {
            var registerValue: Int
            if isStringNumeric(theString: componentArray[1]) {
                registerValue = Int(componentArray[1])!
            } else {
                registerValue = registers[componentArray[1]]!
            }
            
            //print ("tgl register value \(registerValue)")
            let programCounterToModify = programCounter + registerValue
            if programCounterToModify >= 0 && programCounterToModify < instructionArray.count {
                let lineToModify = instructionArray[programCounterToModify]
                //print ("command to be changed: \(lineToModify)")
                var componentsToModify = lineToModify.components(separatedBy: " ")
                if componentsToModify.count == 2 {
                    //print ("One")
                    if componentsToModify[0] == "inc" {
                        componentsToModify[0] = "dec"
                    } else {
                        componentsToModify[0] = "inc"
                    }
                } else if componentsToModify.count == 3 {
                    //print ("Two")
                    if componentsToModify[0] == "jnz" {
                        componentsToModify[0] = "cpy"
                    } else {
                        componentsToModify[0] = "jnz"
                    }
                } else {
                    print ("Unknown number of components to modify: \(componentsToModify)")
                }
                
                instructionArray[programCounterToModify] = componentsToModify.joined(separator: " ")
                //print ("command changed to \(instructionArray[programCounterToModify])")
            }
            
            programCounter += 1
        } else {
            print ("Unknown command: \(componentArray[0])")
            programCounter += 1
        }
    }
    
    return registers[registerToRetrieve]!
}

func processInstructionsFaster(instructionArray: [Instruction], registerToRetrieve: Int, registers: [Int], displayRegisters: Bool) -> Int {
    var instructionArray = instructionArray
    var registers = registers
    var programCounter = 0
    var ctr = 0
    while programCounter < instructionArray.count {
        if displayRegisters {
            ctr += 1
            if ctr % 1000 == 0 {
                print ("Registers: \(registers)")
            }
        }
        
        let line = instructionArray[programCounter]
        if line.opcode == .cpy {
            let p1 = line.param1
            let p2 = line.param2!
            if p2.registerIndex != nil {
                var registerValue: Int
                if p1.numericValue != nil {
                    registerValue = p1.numericValue!
                } else {
                    registerValue = registers[p1.registerIndex!]
                }
                
                registers[p2.registerIndex!] = registerValue
            }
            
            programCounter += 1
        } else if line.opcode == .inc {
            let p1 = line.param1
            let registerValue = registers[p1.registerIndex!]
            registers[p1.registerIndex!] = registerValue + 1
            programCounter += 1
        } else if line.opcode == .dec {
            let p1 = line.param1
            let registerValue = registers[p1.registerIndex!]
            registers[p1.registerIndex!] = registerValue - 1
            programCounter += 1
        } else if line.opcode == .jnz {
            let p1 = line.param1
            var p1Value: Int
            if p1.numericValue != nil {
                p1Value = p1.numericValue!
            } else {
                p1Value = registers[p1.registerIndex!]
            }
            
            if p1Value != 0 {
                let reg2 = line.param2!
                var reg2Value: Int
                if reg2.numericValue != nil {
                    reg2Value = reg2.numericValue!
                } else {
                    reg2Value = registers[reg2.registerIndex!]
                }
                
                programCounter += reg2Value
            } else {
                programCounter += 1
            }
        } else if line.opcode == .tgl {
            var registerValue: Int
            let p1 = line.param1
            if p1.numericValue != nil {
                registerValue = p1.numericValue!
            } else {
                registerValue = registers[p1.registerIndex!]
            }
            
            //print ("tgl register value \(registerValue)")
            let programCounterToModify = programCounter + registerValue
            if programCounterToModify >= 0 && programCounterToModify < instructionArray.count {
                var instructionToModify = instructionArray[programCounterToModify]
                //print ("command to be changed: \(lineToModify)")
                if instructionToModify.param2 == nil {
                    //print ("One")
                    if instructionToModify.opcode == .inc {
                        instructionToModify.opcode = .dec
                    } else {
                        instructionToModify.opcode = .inc
                    }
                } else {
                    //print ("Two")
                    if instructionToModify.opcode == .jnz {
                        instructionToModify.opcode = .cpy
                    } else {
                        instructionToModify.opcode = .jnz
                    }
                }
                
                instructionArray[programCounterToModify] = instructionToModify
                //print ("command changed to \(instructionArray[programCounterToModify])")
            }
            
            programCounter += 1
        } else {
            print ("Unknown command: \(line)")
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
        if c[0] == "cpy" {
            op = .cpy
        } else if c[0] == "inc" {
            op = .inc
        } else if c[0] == "dec" {
            op = .dec
        } else if c[0] == "jnz" {
            op = .jnz
        } else {
            op = .tgl
        }
        
        p1 = buildParam(inputString: c[1])
        
        if c.count == 3 {
            p2 = buildParam(inputString: c[2])
        }
        
        let newInstruction = Instruction(opcode: op!, param1: p1!, param2: p2)
        instructionSet.append(newInstruction)
    }
    
    return instructionSet
}

let test = puzzleInputTest.components(separatedBy: "~").filter { $0.characters.count > 0 }
let testInstructionSet = buildInstructionSet(lineArray: test)
//print (testInstructionSet)
let testRegisters = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
let testRegisterArray = [ 0, 0, 0, 0 ]
let testSolution = processInstructions(instructionArray: test, registerToRetrieve: "a", registers: testRegisters, displayRegisters: false)
print ("Test solution: \(testSolution)")
let testSolution2 = processInstructionsFaster(instructionArray: testInstructionSet, registerToRetrieve: 0, registers: testRegisterArray, displayRegisters: false)
print ("Test solution 2: \(testSolution2)")

let part1 = puzzleInput.components(separatedBy: "~").filter { $0.characters.count > 0 }
let part1InstructionSet = buildInstructionSet(lineArray: part1)
let part1Registers = [ "a": 7, "b": 0, "c": 0, "d": 0 ]
let part1RegisterArray = [ 7, 0, 0, 0 ]
let part1Solution = processInstructions(instructionArray: part1, registerToRetrieve: "a", registers: part1Registers, displayRegisters: false)
print ("Part 1 solution: \(part1Solution)")
let part1Solution2 = processInstructionsFaster(instructionArray: part1InstructionSet, registerToRetrieve: 0, registers: part1RegisterArray, displayRegisters: false)
print ("Part 1 solution 2: \(part1Solution2)")

//let part2Registers = [ "a": 12, "b": 0, "c": 0, "d": 0 ]
//let part2Solution = processInstructions(instructionArray: part1, registerToRetrieve: "a", registers: part2Registers, displayRegisters: true)
//print ("Part 2 solution: \(part2Solution)")
let part2InstructionSet = buildInstructionSet(lineArray: part1)
let part2RegisterArray = [ 12, 0, 0, 0 ]
let part2Solution2 = processInstructionsFaster(instructionArray: part2InstructionSet, registerToRetrieve: 0, registers: part2RegisterArray, displayRegisters: true)
print ("Part 2 solution: \(part2Solution2)")
