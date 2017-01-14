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

struct Path {
    var startingNumber: Int
    var endingNumber: Int
    var length: Int
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
        if grid.grid[from.y + m.y][from.x + m.x] != "#" {
            validMoves.append(GridPosition(x: (from.x + m.x), y: (from.y + m.y)))
        }
    }
    
    return validMoves
}

func findShortestDistance(grid: Grid, from: GridPosition, to: GridPosition) -> Int {
    var locationsSeen: Set<GridPosition> = Set()
    locationsSeen.insert(from)
    var positions: [GridPosition] = [from]
    var nextPositions: [GridPosition]
    var moveCounter = 0
    while true {
        moveCounter += 1
        nextPositions = []
        for p in positions {
            let moves = getValidMoves(grid: grid, from: p)
            for m in moves {
                if m == to {
                    return moveCounter
                }
                
                if !locationsSeen.contains(m) {
                    locationsSeen.insert(m)
                    nextPositions.append(m)
                }
            }
        }
        
        positions = nextPositions
    }
}

func getPathPermutations(count: Int, returnToZero: Bool) -> [[Int]] {
    var permutations: [[Int]] = []
    
    func pathPermutations(n:Int, _ a: inout Array<Int>) {
        if n == 1 {
            permutations.append(a)
            return
        }
        
        for i in 0..<n - 1 {
            pathPermutations(n: n - 1, &a)
            swap(&a[n - 1], &a[(n % 2 == 1) ? 0 : i])
        }
        pathPermutations(n: n - 1, &a)
    }

    var intArray = [ 0 ]
    if returnToZero {
        intArray.append(0)
    }
    
    for idx in 1..<count {
        intArray.append(idx)
    }
    
    pathPermutations(n: intArray.count, &intArray)
    return permutations
}

func solveGrid(grid: Grid, returnToZero: Bool) -> (Int, [Int]) {
    var pathArray: [Path] = []
    for i in grid.numberLocations {
        for j in grid.numberLocations {
            if i.number != j.number {
                let d = findShortestDistance(grid: grid, from: i.gridPosition, to: j.gridPosition)
                pathArray.append(Path(startingNumber: Int(String(i.number))!, endingNumber: Int(String(j.number))!, length: d))
            }
        }
    }
    
    let permutations = getPathPermutations(count: grid.numberLocations.count, returnToZero: returnToZero)
    var shortestLength = Int.max
    var shortestPath: [Int] = []
    var filteredPermutations: [[Int]]
    if returnToZero {
        filteredPermutations = permutations.filter({ $0[0] == 0 && $0[$0.count - 1] == 0 })
    } else {
        filteredPermutations = permutations.filter({ $0[0] == 0 })
    }
    
    for p in filteredPermutations {
        var moveCount = 0
        for idx in 0..<p.count - 1 {
            let from = p[idx]
            let to = p[idx + 1]
            let path = pathArray.filter({ $0.startingNumber == from && $0.endingNumber == to }).first!
            moveCount += path.length
        }
        
        if moveCount < shortestLength {
            shortestLength = moveCount
            shortestPath = p
        }
    }
    
    return (shortestLength, shortestPath)
}

let testGrid = buildGrid(inputString: testInput)
let testSolution = solveGrid(grid: testGrid, returnToZero: false)
print ("Test solution: \(testSolution)")

let puzzleGrid = buildGrid(inputString: puzzleInput)
let part1Solution = solveGrid(grid: puzzleGrid, returnToZero: false)
print ("Part 1 solution: \(part1Solution)")

let part2Solution = solveGrid(grid: puzzleGrid, returnToZero: true)
print ("Part 2 solution: \(part2Solution)")
