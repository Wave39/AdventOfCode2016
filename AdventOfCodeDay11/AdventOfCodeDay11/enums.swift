//
//  enums.swift
//  AdventOfCodeDay11
//
//  Created by Brian Prescott on 12/27/16.
//  Copyright © 2016 Wave 39 LLC. All rights reserved.
//

import Foundation

enum DeviceType : Int {
    case Microchip = 1
    case Generator
}

let deviceDict: Dictionary<DeviceType, String> = [
    .Microchip : "M",
    .Generator : "G"
]

enum ElementType: Int {
    case Cobalt = 1
    case Curium
    case Dilithium
    case Elerium
    case Hydrogen
    case Lithium
    case Promethium
    case Plutonium
    case Ruthenium
}

let elementDict: Dictionary<ElementType, String> = [
    .Cobalt: "Co",
    .Curium: "Cm",
    .Dilithium: "Di",
    .Elerium: "El",
    .Hydrogen : "H",
    .Lithium : "L",     // yes, it's not the elemental symbol, but it looks better formatted into the diagram
    .Promethium: "Pm",
    .Plutonium: "Pu",
    .Ruthenium: "Ru",
]

enum ElevatorDirection : Int {
    case Up = 1
    case Down
}
