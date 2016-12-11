// Advent Of Code
// Day 4
// http://adventofcode.com/2016/day/4

import Cocoa

let puzzleInputPath = Bundle.main.path(forResource: "puzzle_input", ofType: "txt")
let puzzleInputData = FileManager.default.contents(atPath: puzzleInputPath!)
let puzzleInputString = String(data: puzzleInputData!, encoding: .utf8)
let puzzleInputLineArray = puzzleInputString?.components(separatedBy: "\n").filter { $0.characters.count > 0 }

let alphabet = "abcdefghijklmnopqrstuvwxyz"

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
}

func rotateCharacter(c: Character, rotations: Int) -> Character {
    let index = alphabet.indexOfCharacter(char: c)
    if index == nil {
        return c
    }
    
    let r = rotations % 26
    let rFinal: Int = (r + index!) % 26
    let x = alphabet[rFinal]
    return Character(x)
}

struct CharacterCounter {
    var theCharacter = ""
    var theCount = 0
}

func matchesInCapturingGroups(text: String, pattern: String) -> [String] {
    var results = [String]()
    
    let textRange = NSMakeRange(0, text.lengthOfBytes(using: String.Encoding.utf8))
    
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: text, options: NSRegularExpression.MatchingOptions.reportCompletion, range: textRange)
        
        for index in 1..<matches[0].numberOfRanges {
            results.append((text as NSString).substring(with: matches[0].rangeAt(index)))
        }
        return results
    } catch {
        return []
    }
}

var part1Sum = 0
var part2SectorIDFound = 0
for line in puzzleInputLineArray! {
    var dict: Dictionary<String, Int> = Dictionary()
    let n = matchesInCapturingGroups(text: line, pattern: "([a-z-]+)([0-9]+)\\[([a-z]+)\\]")
    let encryptedName = n[0]
    let sectorID = Int(n[1])!
    let checksum = n[2]
    var decryptedName = ""
    for c in encryptedName.characters {
        let cString = "\(c)"
        if cString != "-" {
            if dict[cString] == nil {
                dict[cString] = 1
            } else {
                dict[cString] = dict[cString]! + 1
            }
        }
        
        let newC = rotateCharacter(c: c, rotations: sectorID)
        decryptedName += "\(newC)"
    }
    
    var arr: Array<CharacterCounter> = Array()
    for k in dict.keys {
        var x = CharacterCounter()
        x.theCharacter = k
        x.theCount = dict[k]!
        arr.append(x)
    }
    
    arr.sort { (lhs: CharacterCounter, rhs: CharacterCounter) -> Bool in
        if lhs.theCount == rhs.theCount {
            return lhs.theCharacter < rhs.theCharacter
        } else {
            return lhs.theCount > rhs.theCount
        }
    }
    
    var idx = 0
    var matchingCharacters = 0
    for c in checksum.characters {
        let cString = "\(c)"
        if cString == arr[idx].theCharacter {
            matchingCharacters += 1
        }
        
        idx += 1
    }
    
    if matchingCharacters == 5 {
        part1Sum += sectorID
        if decryptedName == "northpole-object-storage-" {
            part2SectorIDFound = sectorID
        }
    }
}

print (part1Sum, terminator: "")
print (part2SectorIDFound, terminator: "")
