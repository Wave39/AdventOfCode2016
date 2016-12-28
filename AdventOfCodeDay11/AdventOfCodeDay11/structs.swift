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
}

struct BuildingStatus {
    var movesSoFar: Int
    var elevatorFloor: Int
    var floorArray: [[Device]]
    
    func diagram() -> String {
        var s = ""
        for i in (0...3).reversed() {
            s = s + "\(i + 1) "
            if i == elevatorFloor {
                s += "E "
            } else {
                s += "- "
            }
            
            for dev in floorArray[i] {
                s += dev.description()
            }
            
            s += "\n"
        }
        
        s += "Moves so far: \(movesSoFar)\n"
        
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
