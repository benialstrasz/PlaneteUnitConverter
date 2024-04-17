//
//  NoteItem.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import Foundation
import SwiftData

@Model
final class NoteItem {
    var timestamp: Date
    var text: String
    
    init(timestamp: Date, text: String) {
        self.timestamp = timestamp
        self.text = text
    }
}
