//
//  enums.swift
//  AdventOfCodeDay11
//
//  Created by Brian Prescott on 12/27/16.
//  Copyright © 2016 Wave 39 LLC. All rights reserved.
//

import Foundation

enum DeviceType {
    case Microchip
    case Generator
}

let deviceDict: Dictionary<DeviceType, String> = [
    .Microchip : "M",
    .Generator : "G"
]

enum ElementType {
    case Cobalt
    case Curium
    case Hydrogen
    case Lithium
    case Promethium
    case Plutonium
    case Ruthenium
}

let elementDict: Dictionary<ElementType, String> = [
    .Cobalt: "Co",
    .Curium: "Cm",
    .Hydrogen : "H",
    .Lithium : "L",     // yes, it's not the elemental symbol, but it looks better formatted into the diagram
    .Promethium: "Pm",
    .Plutonium: "Pu",
    .Ruthenium: "Ru"
]
