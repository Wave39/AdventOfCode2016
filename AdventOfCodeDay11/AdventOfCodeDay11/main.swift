// Advent Of Code
// Day 11
// http://adventofcode.com/2016/day/11

import Foundation

var buildingsAlreadySeen: Set<String> = Set()

func devicesDescription(devices: [Device]) -> String {
    var s = ""
    let sorted = devices.sorted() { [$0.elementType.rawValue, $0.deviceType.rawValue].lexicographicallyPrecedes([$1.elementType.rawValue, $1.deviceType.rawValue]) }
    
    for d in sorted {
        s += d.description()
    }
    
    return s
}

func microchipsAndGeneratorsAreSafe(devices: [Device]) -> Bool {
    let microchips = devices.filter { $0.deviceType == .Microchip }
    let generators = devices.filter { $0.deviceType == .Generator }
    var ok = true
    for microchip in microchips {
        var matchingGenerator = false
        var otherGenerator = false
        for generator in generators {
            if microchip.elementType == generator.elementType {
                matchingGenerator = true
            } else {
                otherGenerator = true
            }
        }
        
        if otherGenerator && !matchingGenerator {
            ok = false
        }
    }
    
    return ok
}

func isMoveValid(building: BuildingStatus, move: Move) -> Bool {
    // check the devices being left on the current floor when the elevator leaves
    var remainingDevices = building.floorArray[building.elevatorFloor]
    for d in move.devicesToCarry {
        let idx = remainingDevices.index { $0 == d }
        remainingDevices.remove(at: idx!)
    }
    
    if !microchipsAndGeneratorsAreSafe(devices: remainingDevices) {
        return false
    }
    
    // check the next floor devices
    let nextFloor = building.elevatorFloor + (move.elevatorDirection == .Up ? 1 : -1)
    var nextFloorDevices = building.floorArray[nextFloor]
    nextFloorDevices.append(contentsOf: move.devicesToCarry)
    let ok = microchipsAndGeneratorsAreSafe(devices: nextFloorDevices)
    
    let nextBuilding = findNextBuilding(building: building, move: move)
    let nextBuildingString = BuildingState.getBuildingState(building: nextBuilding)
    if buildingsAlreadySeen.contains(nextBuildingString) {
        return false
    } else {
        buildingsAlreadySeen.insert(nextBuildingString)
    }

    return ok
}

func findValidMoves(building: BuildingStatus) -> [Move] {
    var v = Array<Move>()
    
    var elevatorDirections: [ElevatorDirection] = []
    if building.elevatorFloor == 0 {
        elevatorDirections.append(.Up)
    } else if building.elevatorFloor == 1 {
        elevatorDirections.append(.Up)
        if building.floorArray[0].count > 0 {
            elevatorDirections.append(.Down)
        }
    } else if building.elevatorFloor == 2 {
        elevatorDirections.append(.Up)
        if building.floorArray[0].count > 0 || building.floorArray[1].count > 0 {
            elevatorDirections.append(.Down)
        }
    } else {
        elevatorDirections.append(.Down)
    }
    
    // do the one at a time moves first
    let deviceArray = building.floorArray[building.elevatorFloor]
    for device in deviceArray {
        for ed in elevatorDirections {
            let m = Move(elevatorDirection: ed, devicesToCarry: [device])
            if isMoveValid(building: building, move: m) {
                v.append(m)
            }
        }
    }
    
    // now consider moving 2 devices at a time
    if deviceArray.count >= 2 {
        for i in 0...deviceArray.count - 2 {
            for j in i + 1...deviceArray.count - 1 {
                let chipsOK = (deviceArray[i].deviceType == deviceArray[j].deviceType || deviceArray[i].elementType == deviceArray[j].elementType)
                if chipsOK {
                    for ed in elevatorDirections {
                        let m = Move(elevatorDirection: ed, devicesToCarry: [ deviceArray[i], deviceArray[j] ])
                        if isMoveValid(building: building, move: m) {
                            v.append(m)
                        }
                    }
                }
            }
        }
    }
    
    return v
}

func findNextBuilding(building: BuildingStatus, move: Move) -> BuildingStatus {
    var nextBuilding = building
    nextBuilding.history += "Move: \(move.description())\n"
    
    nextBuilding.movesSoFar += 1
    let previousFloor = building.elevatorFloor
    let nextFloor = building.elevatorFloor + (move.elevatorDirection == .Up ? 1 : -1)
    
    for d in move.devicesToCarry {
        let idx = nextBuilding.floorArray[previousFloor].index { $0 == d }
        nextBuilding.floorArray[previousFloor].remove(at: idx!)
        nextBuilding.floorArray[nextFloor].append(d)
    }
    
    nextBuilding.elevatorFloor = nextFloor
    nextBuilding.history += nextBuilding.diagram(includeMoveCounter: true)
    
    return nextBuilding
}

func findSolution(initialConfiguration: [[Device]], totalNumberOfDevices: Int) -> Int {
    buildingsAlreadySeen = Set()
    var initialBuilding = BuildingStatus(movesSoFar: 0, elevatorFloor: 0, floorArray: initialConfiguration, history: "")
    initialBuilding.history = initialBuilding.diagram(includeMoveCounter: true)
    var foundSolutionAtMove = 0
    var currentBuildingArray = [ initialBuilding ]
    while foundSolutionAtMove == 0 {
        var nextBuildingArray: [ BuildingStatus ] = []
        for bldg in currentBuildingArray {
            let validMoves = findValidMoves(building: bldg)
            for move in validMoves {
                let nextBuilding = findNextBuilding(building: bldg, move: move)
                nextBuildingArray.append(nextBuilding)
                if nextBuilding.floorArray[3].count == totalNumberOfDevices {
                    foundSolutionAtMove = nextBuilding.movesSoFar
                }
            }
        }
        
        currentBuildingArray = nextBuildingArray
    }
    
    return foundSolutionAtMove
}

let testSolution = findSolution(initialConfiguration: puzzleInputTest, totalNumberOfDevices: 4)
print ("Test solution: \(testSolution)")

let part1Solution = findSolution(initialConfiguration: puzzleInputPart1, totalNumberOfDevices: 10)
print ("Part 1 solution: \(part1Solution)")

let part2Solution = findSolution(initialConfiguration: puzzleInputPart2, totalNumberOfDevices: 14)
print ("Part 2 solution: \(part2Solution)")
