// Advent Of Code
// Day 24
// http://adventofcode.com/2016/day/24

import Foundation

struct GridPosition : Hashable {
    var x: Int
    var y: Int
    
    var hashValue: Int {
        return self.x * 1000 + self.y
    }
    
    static func ==(left: GridPosition, right: GridPosition) -> Bool {
        return left.hashValue == right.hashValue
    }
}

struct NumberLocation {
    var gridPosition: GridPosition
    var number: Character
}

struct Grid {
    var grid: [[Character]]
    var numberLocations: [NumberLocation]
    var maxX: Int
    var maxY: Int
}

func buildGrid(inputString: String) -> Grid {
    let lineArray = inputString.components(separatedBy: "~").filter { $0.characters.count > 0 }
    var gridArray: [[Character]] = []
    var numberLocationArray: [NumberLocation] = []
    let maxY = lineArray.count - 2
    let maxX = lineArray[0].characters.count - 2
    for y in 0..<maxY {
        let theLine = lineArray[y + 1]
        var arr: [Character] = []
        for x in 0..<maxX {
            let theChar = theLine[x + 1].characters.first!
            if theChar == "#" {
                arr.append("#")
            } else if theChar == "." {
                arr.append(".")
            } else {
                arr.append(theChar)
                let numberLocation = NumberLocation(gridPosition: GridPosition(x: x, y: y), number: theChar)
                numberLocationArray.append(numberLocation)
            }
        }
        
        gridArray.append(arr)
    }
    
    return Grid(grid: gridArray, numberLocations: numberLocationArray, maxX: maxX, maxY: maxY)
}

func printGrid(grid: Grid) {
    for y in grid.grid {
        var s = ""
        for x in y {
            s = s + "\(x)"
        }
        
        print (s)
    }
}

func getValidMoves(grid: Grid, from: GridPosition) -> [GridPosition] {
    var possibleMoves: [GridPosition] = []
    
    if from.x > 0 {
        possibleMoves.append(GridPosition(x: -1, y: 0))
    }
    
    if from.x < (grid.maxX - 1) {
        possibleMoves.append(GridPosition(x: 1, y: 0))
    }
    
    if from.y > 0 {
        possibleMoves.append(GridPosition(x: 0, y: -1))
    }
    
    if from.y < (grid.maxY - 1) {
        possibleMoves.append(GridPosition(x: 0, y: 1))
    }
    
    var validMoves: [GridPosition] = []
    for m in possibleMoves {
        if grid.grid[from.x + m.x][from.y + m.y] != "#" {
            validMoves.append(m)
        }
    }
    
    return validMoves
}

func findShortestDistance(grid: Grid, from: GridPosition, to: GridPosition) -> Int {
    var locationsSeen: Set<GridPosition> = Set()
    locationsSeen.insert(from)
    var positions: [GridPosition] = [from]
    while true {
        for p in positions {
        }
    }
    return 0
}

func solveGrid(grid: Grid) {
    for i in grid.numberLocations {
        for j in grid.numberLocations {
            if i.number != j.number {
                print ("Finding shortest distance from \(i) to \(j)")
                let d = findShortestDistance(grid: grid, from: i.gridPosition, to: j.gridPosition)
            }
        }
    }
}

let testGrid = buildGrid(inputString: testInput)
printGrid(grid: testGrid)
solveGrid(grid: testGrid)

let part1Grid = buildGrid(inputString: puzzleInput)
printGrid(grid: part1Grid)
