//
//  Array.swift
//  DigitasWorld
//
//  Created by ashok on 03/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

extension Array where Element == String {
 
    var toString : String {
        get {
            
            if concatenate().count > 0 {
                let str = concatenate()
                let start = str.startIndex
                let end = str.index(str.endIndex, offsetBy: -2)
                let range = start..<end
                return String(str[range])
            }
            return "-"
        }
    }
    
    func concatenate() -> String {
        let result = reduce("") { (result, y) in
            return result + y + ", "
        }
        return result
    }
}
