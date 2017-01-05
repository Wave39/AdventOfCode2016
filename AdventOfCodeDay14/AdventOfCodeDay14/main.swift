// Advent Of Code
// Day 14
// http://adventofcode.com/2016/day/14

import Foundation

//let puzzleInput = "abc"
let puzzleInput = "qzyelonm"

func MD5(string: String) -> String {
    guard let messageData = string.data(using:String.Encoding.utf8) else { return "" }
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    
    _ = digestData.withUnsafeMutableBytes {digestBytes in
        messageData.withUnsafeBytes {messageBytes in
            CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
        }
    }
    
    let str = digestData.map { String(format: "%02hhx", $0) }.joined()
    return str
}

func MD5ForIndex(inputString: String, index: Int, stretch: Bool) -> String {
    let key = "\(inputString)\(index)"
    var md5 = MD5(string: key)
    if stretch {
        for _ in 1...2016 {
            md5 = MD5(string: md5)
        }
    }
    
    return md5
}

func getTripleCharacter(string: String) -> String {
    for i in 0..<string.length - 2 {
        if string[i] == string[i + 1] && string[i] == string[i + 2] {
            return string[i]
        }
    }
    
    return "?"
}

func findMatches(inputString: String, stretch: Bool) -> [ Int ] {
    var hashFound = false
    var index = 0
    var hashDictionary: Dictionary<Int, String> = [ : ]
    var validKeys: [ Int ] = []
    
    func getIndexValue(index: Int) -> String {
        if hashDictionary[index] == nil {
            hashDictionary[index] = MD5ForIndex(inputString: inputString, index: index, stretch: stretch)
        }
        
        return hashDictionary[index]!
    }
    
    while !hashFound {
        let hashValue = getIndexValue(index: index)
        let matchedCharacter = getTripleCharacter(string: hashValue)
        if matchedCharacter != "?" {
            let searchFor = String(repeating: matchedCharacter, count: 5)
            for nextIndex in (index + 1)...(index + 1000) {
                let nextHashValue = getIndexValue(index: nextIndex)
                if nextHashValue.range(of: searchFor) != nil {
                    validKeys.append(index)
                    break
                }
            }
        }
        
        index += 1
        if validKeys.count == 64 {
            hashFound = true
        }
    }
    
    return validKeys
}

let part1Solution = findMatches(inputString: puzzleInput, stretch: false).last!
print (part1Solution)
let part2Solution = findMatches(inputString: puzzleInput, stretch: true).last!
print (part2Solution)
