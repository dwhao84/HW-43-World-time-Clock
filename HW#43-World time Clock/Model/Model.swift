//
//  Model.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import Foundation
let regions: [Locale.Region] = Locale.Region.isoRegions
let timeZone = TimeZone.knownTimeZoneIdentifiers
let location: [String] = []

struct TimeInfo {
    let timeZone: String
}

