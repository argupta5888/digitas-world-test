//
//  Log.swift
//  DigitasWorld
//
//  Created by ashok on 03/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import os

private let subsystem = "com.DigitasWorld"

struct Log {
    static let networking = OSLog(subsystem: subsystem, category: "networking")
    static let table = OSLog(subsystem: subsystem, category: "table")
}


// First Commit


//Added new details 
