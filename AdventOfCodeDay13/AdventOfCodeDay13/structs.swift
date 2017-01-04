//
//  structs.swift
//  AdventOfCodeDay13
//
//  Created by Brian Prescott on 1/2/17.
//  Copyright © 2017 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Coordinate {
    var x: Int
    var y: Int

    static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func !=(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return !(lhs == rhs)
    }
    
    func description() -> String {
        return "\(self.x) \(self.y)"
    }
}

struct MoveState {
    var currentCoordinate: Coordinate
    var previousCoordinate: Coordinate
    var numberOfMoves: Int
}
