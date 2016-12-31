//
//  structs.swift
//  AdventOfCodeDay11
//
//  Created by Brian Prescott on 12/27/16.
//  Copyright © 2016 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Device {
    var elementType: ElementType
    var deviceType: DeviceType
    
    func description() -> String {
        return "\(elementDict[self.elementType]!)\(deviceDict[self.deviceType]!) "
    }
    
    static func ==(lhs: Device, rhs: Device) -> Bool {
        return lhs.elementType == rhs.elementType && lhs.deviceType == rhs.deviceType
    }
}

struct BuildingStatus {
    var movesSoFar: Int
    var elevatorFloor: Int
    var floorArray: [[Device]]
    var history: String
    
    func diagram(includeMoveCounter: Bool) -> String {
        var s = ""
        for i in (0...3).reversed() {
            s = s + "\(i + 1) "
            if i == elevatorFloor {
                s += "E "
            } else {
                s += "- "
            }
            
            s += devicesDescription(devices: floorArray[i])
            s += "\n"
        }
        
        if includeMoveCounter {
            s += "Moves so far: \(movesSoFar)\n"
        }
        
        return s
    }
}

struct Move {
    var elevatorDirection: ElevatorDirection
    var devicesToCarry: [Device]
    
    func description() -> String {
        var s = (elevatorDirection == .Up ? "Up " : "Down ")
        let sorted = devicesToCarry.sorted() { [$0.elementType.rawValue, $0.deviceType.rawValue].lexicographicallyPrecedes([$1.elementType.rawValue, $1.deviceType.rawValue]) }
        
        for d in sorted {
            s += d.description()
        }
        
        return s;
    }
}

struct BuildingState {
    var floorArray: [[Int]]
    var elevatorFloor: Int
    
    func description() -> String {
        return "\(floorArray) \(elevatorFloor)"
    }
    
    static func getBuildingState(building: BuildingStatus) -> String {
        var buildingState = BuildingState(floorArray: [[0,0,0],[0,0,0],[0,0,0],[0,0,0]], elevatorFloor: 0)
        for i in 0...3 {
            for j in building.floorArray[i] {
                if j.deviceType == .Microchip {
                    let d = Device(elementType: j.elementType, deviceType: .Generator)
                    if !building.floorArray[i].contains(where: {$0 == d}) {
                        buildingState.floorArray[i][0] += 1
                    } else {
                        buildingState.floorArray[i][2] += 1
                    }
                } else {
                    let d = Device(elementType: j.elementType, deviceType: .Microchip)
                    if !building.floorArray[i].contains(where: {$0 == d}) {
                        buildingState.floorArray[i][1] += 1
                    }
                }
            }
        }
        
        buildingState.elevatorFloor = building.elevatorFloor
        
        return buildingState.description()
    }
}
