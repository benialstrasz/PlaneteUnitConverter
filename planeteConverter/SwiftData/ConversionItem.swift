//
//  ConversionItem.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import Foundation
import SwiftData

@Model
final class ConversionItem {
    var timestamp: Date
    
    var value1: Double
    var prefix1: Prefix
    var unit1: Unit
    var value2: Double
    var unit2: Unit
    
    init(timestamp: Date, value1: Double, prefix1: Prefix, unit1: Unit, value2: Double, unit2: Unit) {
        self.timestamp = timestamp
        self.value1 = value1
        self.prefix1 = prefix1
        self.unit1 = unit1
        self.value2 = value2
        self.unit2 = unit2
    }
}
