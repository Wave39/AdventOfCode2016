// Advent Of Code
// Day 14
// http://adventofcode.com/2016/day/14

import Foundation

let part1Input = "abc"

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

func getTripleCharacter(string: String) -> String {
    for i in 0..<string.length - 2 {
        if string[i] == string[i + 1] && string[i] == string[i + 2] {
            return string[i]
        }
    }
    
    return "?"
}

let md5 = MD5(string: "abc18")
print (md5)

func findMatch(inputString: String) {
    var hashFound = false
    var index = 0
    var hashDictionary: Dictionary<Int, String> = [ : ]
    
    while !hashFound {
        if hashDictionary[index] == nil {
            let key = "\(inputString)\(index)"
            hashDictionary[index] = MD5(string: key)
        }
        
        let hashValue = hashDictionary[index]!
        let matchedCharacter = getTripleCharacter(string: hashValue)
        if matchedCharacter != "?" {
            print ("Hash of \(index) is \(hashValue) with match character \(matchedCharacter)")
        }
        
        index += 1
        if index > 24000 {
            hashFound = true
        }
    }
}

findMatch(inputString: part1Input)
