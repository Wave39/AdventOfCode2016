// Advent Of Code
// Day 13
// http://adventofcode.com/2016/day/13

import Foundation

let origin = Coordinate(x: 1, y: 1)
//let goal = Coordinate(x: 7, y: 4)
//let favoriteNumber = 10
let goal = Coordinate(x: 31, y: 39)
let favoriteNumber = 1364

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

func processMoveState(moveState: MoveState, goal: Coordinate) -> Int {
    
    var currentStates = [ moveState ]
    var goalFound = 0
    var ctr = 0
    
    while goalFound == 0 {
        ctr += 1
        print (ctr)
        var nextStates: [ MoveState ] = []
        for state in currentStates {
            let validMoves = getValidMoveCoordinates(moveState: state)
            for move in validMoves {
                let nextMove = MoveState(currentCoordinate: move, previousCoordinate: state.currentCoordinate, numberOfMoves: state.numberOfMoves + 1)
                nextStates.append(nextMove)
                if move == goal {
                    goalFound = nextMove.numberOfMoves
                }
            }
        }
        
        currentStates = nextStates
    }
    
    return goalFound
}

let part1 = MoveState(currentCoordinate: origin, previousCoordinate: origin, numberOfMoves: 0)

let part1Solution = processMoveState(moveState: part1, goal: goal)
print ("Part 1 solution: \(part1Solution)")
