//
//  Units.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import Foundation

final public class Unit: Identifiable, Codable {
    var name: String
    var abbreviation: String
    var value: Double
    var category: category
    var SIvalue: Double?
    var SIunits: String?
    var LaTeXunit: String?
    
    enum category: Codable {
        case mass
        case length
        case time
        case energy
        case luminosity
        case temperature
        case force
        case other
        case velocity
        case pressure
        case constant
        case area
        case volume
        case fluxDensity
    }

    init(name: String, abbreviation: String, value: Double, category: category, SIvalue: Double = 0.0, SIunits: String = "", LaTeXunit: String) {
        self.name = name
        self.abbreviation = abbreviation
        self.value = value
        self.category = category
        self.LaTeXunit = LaTeXunit
    }
}

extension Unit: Sequence {
    static let gramm = Unit(name: "gramm", abbreviation: "g", value: (1.0), category: Unit.category.mass, LaTeXunit: "g")
    static let centimeter = Unit(name: "centimeter", abbreviation: "cm", value: (1.0), category: Unit.category.length, LaTeXunit: "cm")
    static let second = Unit(name: "second", abbreviation: "s", value: (1.0), category: Unit.category.time, LaTeXunit: "s")
    static let Kelvin = Unit(name: "Kelvin", abbreviation: "K", value: (1.0), category: Unit.category.temperature, LaTeXunit: "K")
    static let dyne = Unit(name: "dyne", abbreviation: "dyn", value: (gramm.value * centimeter.value / pow(second.value, 2)), category: Unit.category.force, LaTeXunit: "dyn")
    static let erg = Unit(name: "erg", abbreviation: "erg", value: (pow(centimeter.value, 2) * gramm.value / pow(second.value, 2)), category: Unit.category.energy, LaTeXunit: "erg")
    static let Joule = Unit(name: "Joule", abbreviation: "J", value: 1E7 * erg.value, category: .energy, LaTeXunit: "J")
    static let ergPerS = Unit(name: "erg per second", abbreviation: "erg/s", value: erg.value / second.value, category: .luminosity, LaTeXunit: "\\frac{erg}{s}")
    

    static let cm2 = Unit(name: "square centimeter", abbreviation: "cm2", value: (pow(centimeter.value, 2)), category: Unit.category.area, LaTeXunit: "cm^2")
    static let cm3 = Unit(name: "cubic centimeter", abbreviation: "cm3", value: pow(centimeter.value, 3), category: Unit.category.volume, LaTeXunit: "cm^2")
    static let m = Unit(name: "meter", abbreviation: "m", value: (100.0 * centimeter.value), category: Unit.category.length, LaTeXunit: "m")
    static let km = Unit(name: "kilometer", abbreviation: "km", value: (1000.0 * m.value), category: Unit.category.length, LaTeXunit: "km")
    static let ms = Unit(name: "meter per second", abbreviation: "m/s", value: m.value / second.value, category: Unit.category.velocity, LaTeXunit: "\\frac{m}{s}")
    static let kms = Unit(name: "kilometer per second", abbreviation: "km/s", value: (km.value / second.value), category: Unit.category.velocity, LaTeXunit: "\\frac{km}{s}")
    static let Bar = Unit(name: "Bar", abbreviation: "Bar", value: (1E06 * gramm.value / centimeter.value / pow(second.value, 2)), category: Unit.category.pressure, LaTeXunit: "Bar")
    static let Pa = Unit(name: "Pascale", abbreviation: "Pa", value: (10.0 * dyne.value / cm2.value), category: Unit.category.pressure, LaTeXunit: "Pa")
    
    static let pi = Unit(name: "Pi", abbreviation: "π", value: Double.pi, category: Unit.category.other, LaTeXunit: "\\pi")
    static let π = Unit(name: "Pi", abbreviation: "π", value: Double.pi, category: Unit.category.other, LaTeXunit: "\\pi")
    static let pi4 = Unit(name: "4*Pi", abbreviation: "4π", value: 4 * Double.pi, category: Unit.category.other, LaTeXunit: "4\\pi")
    static let G = Unit(name: "Gravitational constant", abbreviation: "G", value: (6.67408e-08 * dyne.value * cm2.value / pow(gramm.value, 2)), category: Unit.category.constant, LaTeXunit: "G")
    static let c = Unit(name: "Speed of light", abbreviation: "c", value: 2.99792458e+10 * centimeter.value / second.value, category: Unit.category.velocity, LaTeXunit: "c")
    
    static let eV = Unit(name: "electron Volt", abbreviation: "eV", value: 1.6021766208e-12 * erg.value, category: Unit.category.energy, LaTeXunit: "eV")
    static let kb = Unit(name: "Boltzmann constant", abbreviation: "kB", value: 1.38064852e-16 * erg.value / Kelvin.value, category: Unit.category.energy, LaTeXunit: "k_B")
    static let hP = Unit(name: "Planck constant", abbreviation: "h", value: 6.626070040e-27 * erg.value * second.value, category: Unit.category.energy, LaTeXunit: "h")
    static let uma = Unit(name: "atomic mass unit", abbreviation: "u", value: 1.660539040e-24 * gramm.value, category: Unit.category.mass, LaTeXunit: "u")
    static let cte_a = Unit(name: "radiation constant A", abbreviation: "A", value: 7.57e-15 * erg.value / cm3.value / pow(Kelvin.value, 4), category: Unit.category.other, LaTeXunit: "A")
    static let NAvo = Unit(name: "Avogadro number", abbreviation: "Nₐ", value: 6.022140857e+23, category: Unit.category.other, LaTeXunit: "N_a")
    static let Rgp = Unit(name: "gas constant", abbreviation: "R", value: 8.3144598e+07 * erg.value / Kelvin.value / gramm.value, category: Unit.category.energy, LaTeXunit: "R")
    static let a0 = Unit(name: "Bohr Radius", abbreviation: "a₀", value: 0.529e-8 * centimeter.value, category: Unit.category.length, LaTeXunit: "a_0")
    static let cfrad = Unit(name: "cfrad", abbreviation: "cfrad", value: -3.0 / (16.0 * Double.pi * cte_a.value * c.value), category: Unit.category.other, LaTeXunit: "c_{frad}")
    static let sigmaPlanck = Unit(name: "σ Planck", abbreviation: "σ", value: cte_a.value * c.value / 4.0, category: Unit.category.other, SIvalue: 5.670374419E-8, SIunits: "W / (m2 x K4", LaTeXunit: "\\sigma")

    static let minute = Unit(name: "minute", abbreviation: "min", value: 60 * second.value, category: .time, LaTeXunit: "min")
    static let day = Unit(name: "day", abbreviation: "day", value: 86400.0 * second.value, category: Unit.category.time, LaTeXunit: "days")
    static let an = Unit(name: "year", abbreviation: "yr", value: 365.25 * day.value, category: Unit.category.time, LaTeXunit: "years")
    static let au = Unit(name: "astronomicalUnit", abbreviation: "au", value: 1.495978707e+13 * centimeter.value, category: Unit.category.length, LaTeXunit: "AU")
    static let ly = Unit(name: "light-year", abbreviation: "ly", value: 9460730472580.8 * km.value, category: .length, LaTeXunit: "ly")
    static let parsec = Unit(name: "parsec", abbreviation: "pc", value: 3.085677581e+18 * centimeter.value, category: Unit.category.length, LaTeXunit: "pc")
    static let Jy = Unit(name: "Jansky", abbreviation: "Jy", value: 1e-23 * erg.value * pow(second.value, -2) / pow(centimeter.value, 2), category: Unit.category.fluxDensity, LaTeXunit: "Jy")
    static let mJy = Unit(name: "milliJansky", abbreviation: "mJy", value: 1e-26 * erg.value * pow(second.value, -2) / pow(centimeter.value, 2), category: Unit.category.fluxDensity, LaTeXunit: "mJy")

    static let Rsun = Unit(name: "solar radius", abbreviation: "R☉", value: 6.957e+05 * km.value, category: Unit.category.length, LaTeXunit: "R_{\\odot}")
    static let Rj = Unit(name: "Jupiter radius", abbreviation: "RJ", value: 7.1492e+04 * km.value, category: Unit.category.length, LaTeXunit: "R_{J}")
    static let Rearth = Unit(name: "earth radius", abbreviation: "R⊕", value: 6.3781e+03 * km.value, category: Unit.category.length, LaTeXunit: "M_\\oplus")
    static let Lsun = Unit(name: "solar luminosity", abbreviation: "L☉", value: 3.828e+33 * erg.value / second.value, category: Unit.category.luminosity, LaTeXunit: "L_{\\odot}")
    static let LJ = Unit(name: "Jupiter luminosity", abbreviation: "LJ", value: 8.67e-10 * Lsun.value, category: Unit.category.luminosity, LaTeXunit: "{L_J}")
    static let GMsun = Unit(name: "solarGravitationalParameter", abbreviation: "GM☉", value: 1.3271244e+26 * pow(centimeter.value, 3) / pow(second.value, 2), category: Unit.category.other, LaTeXunit: "GM_\\odot")
    static let Msun = Unit(name: "solar Mass", abbreviation: "M☉", value: GMsun.value / G.value, category: Unit.category.mass, LaTeXunit: "M_{\\odot}")
    static let GMj = Unit(name: "JupiterGravitationalParameter", abbreviation: "GMJ", value: 1.2668653e+23 * pow(centimeter.value, 3) / pow(second.value, 2), category: Unit.category.other, LaTeXunit: "GM_J")
    static let Mj = Unit(name: "Jupiter Mass", abbreviation: "MJ", value: GMj.value / G.value, category: Unit.category.mass, LaTeXunit: "{M_J}")
    static let GMearth = Unit(name: "earthGravitationalParameter", abbreviation: "GM⊕", value: 3.986004e+20 * pow(centimeter.value, 3) / pow(second.value, 2), category: Unit.category.other, LaTeXunit: "GM_E")
    static let Mearth = Unit(name: "earthMass", abbreviation: "M⊕", value: GMearth.value / G.value, category: Unit.category.mass, LaTeXunit: "{M_\\oplus}")

    
    static var UnitsArray: [Unit] {
        return [gramm, centimeter, second, Kelvin, dyne, erg, Joule, ergPerS, cm2, cm3, m, km, ms, kms, Bar, Pa, pi, π, pi4, G, c, eV, kb, hP, uma, cte_a, NAvo, Rgp, a0, cfrad, sigmaPlanck, day, an, au, ly, parsec, Jy, mJy, Rsun, Rj, Rearth, Lsun, LJ, GMsun, Msun, GMj, Mj, GMearth, Mearth]
    }
    
    // Implement the makeIterator() method required by Sequence protocol
    public func makeIterator() -> IndexingIterator<[Unit]> {
        return Unit.UnitsArray.makeIterator()
    }

}
