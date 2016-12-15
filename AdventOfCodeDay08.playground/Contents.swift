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
    
    func showDisplay() -> () {
        for r in 0..<rows {
            var rowString = ""
            for c in 0..<columns {
                rowString += lightArray[r][c]
            }
            print (rowString)
        }
    }
    
    func rect(w: Int, h: Int) {
        for r in 0..<h {
            for c in 0..<w {
                lightArray[r][c] = "#"
            }
        }
    }
}

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

var part1Display = Display(r: 3, c: 7)
for line in puzzleInputLineArray! {
    let arr = line.components(separatedBy: " ")
    if arr.count > 0 {
        if arr[0] == "rect" {
            let rectArr = arr[1].components(separatedBy: "x")
            let rectWidth = Int(rectArr[0])
            let rectHeight = Int(rectArr[1])
            part1Display.rect(w: rectWidth!, h: rectHeight!)
            
        } else if arr[0] == "rotate" {
        }
    }
}
part1Display.showDisplay()

