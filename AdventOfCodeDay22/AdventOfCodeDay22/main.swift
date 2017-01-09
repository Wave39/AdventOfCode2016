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

// empty cluster is at x 17, y 22
