//
//  Prefix.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 17.04.2024.
//

import Foundation

final public class Prefix: Identifiable, Codable {
    var name: String
    var abbreviation: String
    var value: Double
    
    init(name: String, abbreviation: String, value: Double) {
        self.name = name
        self.abbreviation = abbreviation
        self.value = value
    }
}

extension Prefix: Sequence {
    
    static let none = Prefix(name: " ", abbreviation: " ", value: 1.0)
    
    static let deca = Prefix(name: "deca", abbreviation: "da", value: 10.0)
    static let hecto = Prefix(name: "hecto", abbreviation: "h", value: 100.0)
    static let kilo = Prefix(name: "kilo", abbreviation: "k", value: 1000.0)
    static let mega = Prefix(name: "mega", abbreviation: "M", value: 1000000.0)
    static let giga = Prefix(name: "giga", abbreviation: "G", value: 1000000000.0)
    static let tera = Prefix(name: "tera", abbreviation: "T", value: 1E12)
    
    static let deci = Prefix(name: "deci", abbreviation: "d", value: 0.1)
    static let centi = Prefix(name: "centi", abbreviation: "c", value: 0.01)
    static let milli = Prefix(name: "milli", abbreviation: "m", value: 0.001)
    static let micro = Prefix(name: "micro", abbreviation: "µ", value: 1E-6)
    static let nano = Prefix(name: "nano", abbreviation: "n", value: 1E-9)
    static let pico = Prefix(name: "pico", abbreviation: "p", value: 1E-12)

    static var PrefixArray: [Prefix] {
        return [deca, hecto, kilo, mega, giga, tera, deci, centi, milli, micro, nano, pico]
    }
    
    // Implement the makeIterator() method required by Sequence protocol
    public func makeIterator() -> IndexingIterator<[Prefix]> {
        return Prefix.PrefixArray.makeIterator()
    }

}
