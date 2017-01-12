// Advent Of Code
// Day 24
// http://adventofcode.com/2016/day/24

import Foundation

struct NumberLocation {
    var x: Int
    var y: Int
    var number: Character
}

struct Grid {
    var grid: [[Character]]
    var numberLocations: [NumberLocation]
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
                let numberLocation = NumberLocation(x: x, y: y, number: theChar)
                numberLocationArray.append(numberLocation)
            }
        }
        
        gridArray.append(arr)
    }
    
    return Grid(grid: gridArray, numberLocations: numberLocationArray)
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

let testGrid = buildGrid(inputString: testInput)
printGrid(grid: testGrid)

let part1Grid = buildGrid(inputString: puzzleInput)
printGrid(grid: part1Grid)
