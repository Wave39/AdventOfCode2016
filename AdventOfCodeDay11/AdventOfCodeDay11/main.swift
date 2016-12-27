// Advent Of Code
// Day 11
// http://adventofcode.com/2016/day/11

import Foundation

//let initialConfiguration = puzzleInputTest
let initialConfiguration = puzzleInput

var part1Building = BuildingStatus(elevatorFloor: 0, floorArray: initialConfiguration)
print ("Initial building diagram:\n\(part1Building.diagram())")
