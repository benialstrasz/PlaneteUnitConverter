//
//  CenterModifier.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 17.04.2024.
//

import Foundation
import SwiftUI

// To center any View in a list with the help of HStack and Spacers
struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
extension View {
    func centerModifier() -> some View {
        self.modifier(CenterModifier())
    }
}
