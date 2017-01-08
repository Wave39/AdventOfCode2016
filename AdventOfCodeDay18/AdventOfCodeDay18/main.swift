// Advent Of Code
// Day 18
// http://adventofcode.com/2016/day/18

import Cocoa

enum TileType {
    case Trap
    case Safe
}

extension String {
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }    
}

func convertStringToTileTypes(source: String) -> [TileType] {
    var types: [TileType] = []
    for idx in 0..<source.length {
        types.append(source[idx] == "." ? .Safe : .Trap)
    }
    
    return types
}

func getTileTypes(source: [TileType], index: Int) -> [TileType] {
    var types: [TileType] = []
    
    if index == 0 {
        types.append(.Safe)
        types.append(source[0] == .Safe ? .Safe : .Trap)
        types.append(source[1] == .Safe ? .Safe : .Trap)
    } else if index == source.count - 1 {
        types.append(source[source.count - 2] == .Safe ? .Safe : .Trap)
        types.append(source[source.count - 1] == .Safe ? .Safe : .Trap)
        types.append(.Safe)
    } else {
        types.append(source[index - 1] == .Safe ? .Safe : .Trap)
        types.append(source[index] == .Safe ? .Safe : .Trap)
        types.append(source[index + 1] == .Safe ? .Safe : .Trap)
    }
    
    return types
}

func getNextTileType(types: [TileType]) -> TileType {
    if types[0] == .Trap && types[1] == .Trap && types[2] == .Safe {
        return .Trap
    }
    
    if types[0] == .Safe && types[1] == .Trap && types[2] == .Trap {
        return .Trap
    }
    
    if types[0] == .Trap && types[1] == .Safe && types[2] == .Safe {
        return .Trap
    }
    
    if types[0] == .Safe && types[1] == .Safe && types[2] == .Trap {
        return .Trap
    }
    
    return .Safe
}

func getSafeTileCount(startingRow: String, numberOfRows: Int) -> Int {
    var lastRow = convertStringToTileTypes(source: startingRow)
    var count = lastRow.filter { $0 == .Safe }.count
    var rowsProcessed = 1
    while rowsProcessed < numberOfRows {
        var nextRow: [TileType] = []
        for idx in 0..<lastRow.count {
            let types = getTileTypes(source: lastRow, index: idx)
            if getNextTileType(types: types) == .Trap {
                nextRow.append(.Trap)
            } else {
                nextRow.append(.Safe)
            }
        }
        
        count += nextRow.filter { $0 == .Safe }.count
        lastRow = nextRow
        rowsProcessed += 1
//        if rowsProcessed % 1000 == 0 {    // put this back in if you want to see how fast it is going
//            print (rowsProcessed)
//        }
    }
    
    return count
}

let startingRow = "...^^^^^..^...^...^^^^^^...^.^^^.^.^.^^.^^^.....^.^^^...^^^^^^.....^.^^...^^^^^...^.^^^.^^......^^^^"
let part1Solution = getSafeTileCount(startingRow: startingRow, numberOfRows: 40)
print ("Part 1 solution: \(part1Solution)")

let part2Solution = getSafeTileCount(startingRow: startingRow, numberOfRows: 400000)
print ("Part 2 solution: \(part2Solution)")
