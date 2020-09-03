//
//  Double.swift
//  DigitasWorld
//
//  Created by ashok on 03/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

extension Double {
    var toString : String {
        get {
            return String(format: "%.4f", self)
        }
    }
}
