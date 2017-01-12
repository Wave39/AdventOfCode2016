//
//  constants.swift
//  AdventOfCodeDay23
//
//  Created by Brian Prescott on 1/11/17.
//  Copyright © 2017 Wave 39 LLC. All rights reserved.
//

import Foundation

let puzzleInput = "cpy a b~dec b~cpy a d~cpy 0 a~cpy b c~inc a~dec c~jnz c -2~dec d~jnz d -5~dec b~cpy b c~cpy c d~dec d~inc c~jnz d -2~tgl c~cpy -16 c~jnz 1 c~cpy 98 c~jnz 91 d~inc a~inc d~jnz d -2~inc c~jnz c -5"

let puzzleInputOptimized = "cpy a b~dec b~cpy a d~cpy 0 a~mul b d a~cpy 0 c~cpy 0 d~jnz 0 0~jnz 0 0~jnz 0 0~dec b~cpy b c~cpy c d~dec d~inc c~jnz d -2~tgl c~cpy -16 c~jnz 1 c~cpy 98 c~jnz 91 d~inc a~inc d~jnz d -2~inc c~jnz c -5"
