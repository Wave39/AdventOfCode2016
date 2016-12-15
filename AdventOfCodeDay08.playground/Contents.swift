// Advent Of Code
// Day 8
// http://adventofcode.com/2016/day/8

import Cocoa

class Display {
    var rows: Int
    var columns: Int
    private var lightArray:[[String]]
    
    init(r: Int, c: Int) {
        rows = r
        columns = c
        lightArray = [[String]]()
        for _ in 0..<r {
            var rowArray = [String]()
            for _ in 0..<c {
                rowArray.append(".")
            }
            lightArray.append(rowArray)
        }
    }
    
    func displayString() -> String {
        var retVal = ""
        for r in 0..<rows {
            var rowString = ""
            for c in 0..<columns {
                rowString += lightArray[r][c]
            }
            
            retVal = retVal + rowString + "\n"
        }
        
        return retVal
    }
    
    func rect(w: Int, h: Int) {
        for r in 0..<h {
            for c in 0..<w {
                lightArray[r][c] = "#"
            }
        }
    }

    func rotate(isRow: Bool, rcIndex: Int, rcAmount: Int) {
        for _ in 1...rcAmount {
            if isRow {
                let save = lightArray[rcIndex][columns - 1]
                for idx in (1...columns - 1).reversed() {
                    lightArray[rcIndex][idx] = lightArray[rcIndex][idx - 1]
                }
                
                lightArray[rcIndex][0] = save
            } else {
                let save = lightArray[rows - 1][rcIndex]
                for idx in (1...rows - 1).reversed() {
                    lightArray[idx][rcIndex] = lightArray[idx - 1][rcIndex]
                }
                
                lightArray[0][rcIndex] = save
            }
        }
    }
    
    func lightCounter() -> Int {
        var ctr = 0
        for r in 0..<rows {
            for c in 0..<columns {
                if lightArray[r][c] == "#" {
                    ctr += 1
                }
            }
        }
        
        return ctr
    }

}

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

var part1Display = Display(r: 6, c: 50)
for line in puzzleInputLineArray! {
    let arr = line.components(separatedBy: " ")
    if arr.count > 0 {
        if arr[0] == "rect" {
            let rectArr = arr[1].components(separatedBy: "x")
            let rectWidth = Int(rectArr[0])
            let rectHeight = Int(rectArr[1])
            part1Display.rect(w: rectWidth!, h: rectHeight!)
        } else if arr[0] == "rotate" {
            let rotateRow = (arr[1] == "row")
            let index = Int(arr[2].replacingOccurrences(of: "x=", with: "").replacingOccurrences(of: "y=", with: ""))
            let amount = Int(arr[4])
            part1Display.rotate(isRow: rotateRow, rcIndex: index!, rcAmount: amount!)
        }
    }
}

// press Command+Shift+Y to display the console output, where the displayString method will be readable
print (part1Display.displayString())
print (part1Display.lightCounter(), terminator: "")
