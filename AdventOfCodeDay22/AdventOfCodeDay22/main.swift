// Advent Of Code
// Day 22
// http://adventofcode.com/2016/day/22

import Foundation

extension String {
    func words(with charset: CharacterSet = .alphanumerics) -> [String] {
        return self.unicodeScalars.split {
            !charset.contains($0)
            }.map(String.init)
    }
}

struct Cluster {
    var size: Int
    var used: Int
    var available: Int
    var usePercent: Int
}

struct GameState {
    var clusterArray: [[Cluster]]
    var moves: Int
}

var clusterArray: [[Cluster]] = []
let lineArray = puzzleInput.components(separatedBy: "~")
var clusterLineArray: [Cluster] = []
for line in lineArray {
    let arr = line.words()
    let x = Int(arr[3].replacingOccurrences(of: "x", with: ""))!
    let y = Int(arr[4].replacingOccurrences(of: "y", with: ""))!
    let size = Int(arr[5].replacingOccurrences(of: "T", with: ""))!
    let used = Int(arr[6].replacingOccurrences(of: "T", with: ""))!
    let available = Int(arr[7].replacingOccurrences(of: "T", with: ""))!
    let usePercent = Int(arr[8])!
    let cluster = Cluster(size: size, used: used, available: available, usePercent: usePercent)
    clusterLineArray.append(cluster)
    if y == 25 {
        clusterArray.append(clusterLineArray)
        clusterLineArray = []
    }
}

var part1Solution = 0
for x1 in 0...37 {
    for y1 in 0...25 {
        let c1 = clusterArray[x1][y1]
        for x2 in 0...37 {
            for y2 in 0...25 {
                if x1 != x2 || y1 != y2 {
                    let c2 = clusterArray[x2][y2]
                    if c1.used > 0 && c1.used <= c2.available {
                        part1Solution += 1
                    }
                }
            }
        }
    }
}

print ("Part 1 solution: \(part1Solution)")

func printArray(arr: [[Cluster]]) {
    for y in 0...25 {
        var s = ""
        for x in 0...37 {
            let used = arr[x][y].used
            if used == 0 {
                s = s + "[] "
            } else if used > 99 {
                s = s + "== "
            } else {
                s = s + "\(used) "
            }
        }
        
        print (s)
    }
}

func findPart2Solution() -> Int {
    // 8 up, 17 left, 2 up, 36 right, 12 up, 5 * 36 cycle, 1 left
    return 8 + 17 + 2 + 36 + 12 + (5 * 36) + 1
}

printArray(arr: clusterArray)

let part2Solution = findPart2Solution()
print ("Part 2 solution: \(part2Solution)")
