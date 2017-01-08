//
//  functions.swift
//  AdventOfCodeDay17
//
//  Created by Brian Prescott on 1/7/17.
//  Copyright © 2017 Wave 39 LLC. All rights reserved.
//

import Foundation

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
