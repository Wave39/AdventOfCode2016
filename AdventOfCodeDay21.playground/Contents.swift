// Advent Of Code
// Day 21
// http://adventofcode.com/2016/day/21

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input_test", ofType: "txt")
let passwordToScramble = "abcde"
//let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
//let passwordToScramble = "abcdefgh"

let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

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
    
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }

    mutating func replace(index: Int, newChar: Character) {
        var chars = Array(self.characters)
        chars[index] = newChar
        self = String(chars)
    }
}

func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
    var chars = Array(myString.characters)     // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
}

var part1Password = passwordToScramble
for line in puzzleInputLineArray! {
    let lineArr = line.components(separatedBy: " ")
    if lineArr[0] == "swap" {
        if lineArr[1] == "position" {
            let p1 = Int(lineArr[2])!
            let p2 = Int(lineArr[5])!
            let c1 = Character(part1Password[p1])
            let c2 = Character(part1Password[p2])
            part1Password.replace(index: p1, newChar: c2)
            part1Password.replace(index: p2, newChar: c1)
        } else if lineArr[1] == "letter" {
            let c1 = Character(lineArr[2])
            let c2 = Character(lineArr[5])
            let p1 = part1Password.indexOfCharacter(char: c1)
            let p2 = part1Password.indexOfCharacter(char: c2)
            part1Password.replace(index: p1!, newChar: c2)
            part1Password.replace(index: p2!, newChar: c1)
        } else {
            print ("Invalid swap command: \(lineArr[1])")
        }
    } else if lineArr[0] == "reverse" {
        let idx1 = Int(lineArr[2])!
        let idx2 = Int(lineArr[4])!
        let stringToReverse = part1Password[Range(idx1...idx2)]
        var reversedString = String(stringToReverse.characters.reversed())
        reversedString = part1Password.substring(to: idx1) + reversedString
        reversedString += part1Password.substring(from: idx2 + 1)
    }
}

print (part1Password, terminator: "")
