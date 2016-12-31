// Advent Of Code
// Day 11
// http://adventofcode.com/2016/day/11

import Foundation

//let initialConfiguration = puzzleInputTest
//let numberOfDevicesForSolution = 4
let initialConfiguration = puzzleInput
let numberOfDevicesForSolution = 10

//var movesAlreadySeen: Set<String> = Set()
var buildingsAlreadySeen: Set<String> = Set()

func devicesDescription(devices: [Device]) -> String {
    var s = ""
    let sorted = devices.sorted() { [$0.elementType.rawValue, $0.deviceType.rawValue].lexicographicallyPrecedes([$1.elementType.rawValue, $1.deviceType.rawValue]) }
    
    for d in sorted {
        s += d.description()
    }
    
    return s
}

func isMoveValid(building: BuildingStatus, move: Move) -> Bool {
//    let moveString = move.description()
//    if movesAlreadySeen.contains(moveString) {
//        //print ("The move \(moveString) already has been considered")
//        return false
//    } else {
//        //print ("The move \(moveString) is new")
//        movesAlreadySeen.insert(moveString)
//    }
    
    let nextFloor = building.elevatorFloor + (move.elevatorDirection == .Up ? 1 : -1)
    var nextFloorDevices = building.floorArray[nextFloor]
    nextFloorDevices.append(contentsOf: move.devicesToCarry)
    let microchips = nextFloorDevices.filter { $0.deviceType == .Microchip }
    let generators = nextFloorDevices.filter { $0.deviceType == .Generator }
    //print ("Floor \(nextFloor) will now have microchips \(devicesDescription(devices: microchips)) and generators \(devicesDescription(devices: generators))")
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
    
    let nextBuilding = findNextBuilding(building: building, move: move)
    let nextBuildingString = BuildingState.getBuildingState(building: nextBuilding)
    if buildingsAlreadySeen.contains(nextBuildingString) {
        //print ("The move \(nextBuildingString) already has been considered")
        return false
    } else {
        //print ("The move \(nextBuildingString) is new")
        buildingsAlreadySeen.insert(nextBuildingString)
    }

    //print ("Results are \(ok)")
    
    return ok;
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
        let idx = nextBuilding.floorArray[previousFloor].index { $0.deviceType == d.deviceType && $0.elementType == d.elementType }
        nextBuilding.floorArray[previousFloor].remove(at: idx!)
        nextBuilding.floorArray[nextFloor].append(d)
    }
    
    nextBuilding.elevatorFloor = nextFloor
    nextBuilding.history += nextBuilding.diagram(includeMoveCounter: true)
    
    return nextBuilding
}

func printMoves(arr: [Move]) {
    print ("Valid moves:")
    for m in arr {
        print (m.description())
    }
}

var part1Building = BuildingStatus(movesSoFar: 0, elevatorFloor: 0, floorArray: initialConfiguration, history: "")
part1Building.history = part1Building.diagram(includeMoveCounter: true)
//print ("Initial building diagram:\n\(part1Building.diagram(includeMoveCounter: true))")

var foundSolutionAtMove = 0

var currentBuildingArray = [ part1Building ]
var ctr = 0

while foundSolutionAtMove == 0 && ctr < 100 {
    ctr += 1
    print ("Working on step \(ctr)")
    
    var nextBuildingArray: [ BuildingStatus ] = []
    
    for bldg in currentBuildingArray {
        let validMoves = findValidMoves(building: bldg)
        //printMoves(arr: validMoves)
        for move in validMoves {
            //print ("Move: \(move.description())")
            let nextBuilding = findNextBuilding(building: bldg, move: move)
            //print ("Building after move:\n\(nextBuilding.diagram(includeMoveCounter: true))")
            nextBuildingArray.append(nextBuilding)
            
            if nextBuilding.floorArray[3].count == numberOfDevicesForSolution {
                foundSolutionAtMove = nextBuilding.movesSoFar
                print ("***** WINNER *****")
                print (nextBuilding.history)
                print ("***** WINNER *****")
            }
        }
    }
    
    currentBuildingArray = nextBuildingArray
}

print ("Part 1 solution: \(foundSolutionAtMove)")
