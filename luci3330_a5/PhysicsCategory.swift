//
//  PhysicsCategory.swift
//  luci3330_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 wlu. All rights reserved.
//

import Foundation
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Frog   : UInt32 = 0b1       // 1
    static let Car    : UInt32 = 0b10      // 2
    static let End    : UInt32 = 0b11      // 3
}
