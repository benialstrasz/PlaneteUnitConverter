//
//  Item.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
