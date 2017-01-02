// Advent Of Code
// Day 13
// http://adventofcode.com/2016/day/13

import Foundation

let favoriteNumber = 10
//let favoriteNumber = 1364

func coordinateIsWall(c: Coordinate) -> Bool {
    if c.x < 0 || c.y < 0 {
        return true
    }
    
    let n = (c.x * c.x) + (3 * c.x) + (2 * c.x * c.y) + (c.y) + (c.y * c.y) + favoriteNumber
    let str = String(n, radix: 2)
    let ones = str.characters.filter({$0 == "1"}).count
    return (ones % 2) == 1
}

func getValidMoveCoordinates(moveState: MoveState) -> [Coordinate] {
    var arr : [Coordinate] = []
    
    for xDelta in [ -1, 1] {
        let newCoordinate = Coordinate(x: moveState.currentCoordinate.x + xDelta, y: moveState.currentCoordinate.y)
        if newCoordinate != moveState.previousCoordinate && !coordinateIsWall(c: newCoordinate) {
            arr.append(newCoordinate)
        }
    }
    
    for yDelta in [-1, 1] {
        let newCoordinate = Coordinate(x: moveState.currentCoordinate.x, y: moveState.currentCoordinate.y + yDelta)
        if newCoordinate != moveState.previousCoordinate && !coordinateIsWall(c: newCoordinate) {
            arr.append(newCoordinate)
        }
    }
    
    return arr
}

let origin = Coordinate(x: 1, y: 1)
let part1 = MoveState(currentCoordinate: origin, previousCoordinate: origin, numberOfMoves: 0)
print (part1)

print ("0,0: \(coordinateIsWall(c: Coordinate(x: 0, y: 0)))")
print ("1,0: \(coordinateIsWall(c: Coordinate(x: 1, y: 0)))")

let arr = getValidMoveCoordinates(moveState: part1)
print (arr)
