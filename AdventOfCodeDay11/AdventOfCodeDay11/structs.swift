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
}

struct BuildingStatus {
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
                s += "\(elementDict[dev.elementType]!)\(deviceDict[dev.deviceType]!) "
            }
            
            s = s + "\n"
        }
        
        return s
    }
}
