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

//The first floor contains a promethium generator and a promethium-compatible microchip.
//The second floor contains a cobalt generator, a curium generator, a ruthenium generator, and a plutonium generator.
//The third floor contains a cobalt-compatible microchip, a curium-compatible microchip, a ruthenium-compatible microchip, and a plutonium-compatible microchip.
//The fourth floor contains nothing relevant.
let puzzleInput: [[Device]] = [
    [ Device(elementType: .Promethium, deviceType: .Generator), Device(elementType: .Promethium, deviceType: .Microchip) ],
    [ Device(elementType: .Cobalt, deviceType: .Generator), Device(elementType: .Curium, deviceType: .Generator) , Device(elementType: .Ruthenium, deviceType: .Generator), Device(elementType: .Plutonium, deviceType: .Generator) ],
    [ Device(elementType: .Cobalt, deviceType: .Microchip), Device(elementType: .Curium, deviceType: .Microchip) , Device(elementType: .Ruthenium, deviceType: .Microchip), Device(elementType: .Plutonium, deviceType: .Microchip) ],
    [ ]
]

//The first floor contains a thulium generator, a thulium-compatible microchip, a plutonium generator, and a strontium generator.
//The second floor contains a plutonium-compatible microchip and a strontium-compatible microchip.
//The third floor contains a promethium generator, a promethium-compatible microchip, a ruthenium generator, and a ruthenium-compatible microchip.
//The fourth floor contains nothing relevant.
let puzzleInputAlt: [[Device]] = [
    [ Device(elementType: .Thulium, deviceType: .Generator), Device(elementType: .Thulium, deviceType: .Microchip), Device(elementType: .Plutonium, deviceType: .Generator), Device(elementType: .Strontium, deviceType: .Generator) ],
    [ Device(elementType: .Plutonium, deviceType: .Microchip), Device(elementType: .Strontium, deviceType: .Microchip) ],
    [ Device(elementType: .Promethium, deviceType: .Generator), Device(elementType: .Promethium, deviceType: .Microchip), Device(elementType: .Ruthenium, deviceType: .Generator), Device(elementType: .Ruthenium, deviceType: .Microchip) ],
    [ ]
]
