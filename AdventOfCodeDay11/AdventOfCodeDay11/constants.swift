//
//  constants.swift
//  AdventOfCodeDay11
//
//  Created by Brian Prescott on 12/27/16.
//  Copyright © 2016 Wave 39 LLC. All rights reserved.
//

import Foundation

let puzzleInputTest: [[Device]] = [
    [ Device(elementType: .Hydrogen, deviceType: .Microchip), Device(elementType: .Lithium, deviceType: .Microchip) ],
    [ Device(elementType: .Hydrogen, deviceType: .Generator) ],
    [ Device(elementType: .Lithium, deviceType: .Generator) ],
    [ ]
]

let puzzleInput: [[Device]] = [
    [ Device(elementType: .Promethium, deviceType: .Generator), Device(elementType: .Promethium, deviceType: .Microchip) ],
    [ Device(elementType: .Cobalt, deviceType: .Generator), Device(elementType: .Curium, deviceType: .Generator) , Device(elementType: .Ruthenium, deviceType: .Generator), Device(elementType: .Plutonium, deviceType: .Generator) ],
    [ Device(elementType: .Cobalt, deviceType: .Microchip), Device(elementType: .Curium, deviceType: .Microchip) , Device(elementType: .Ruthenium, deviceType: .Microchip), Device(elementType: .Plutonium, deviceType: .Microchip) ],
    [ ]
]
