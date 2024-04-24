//
//  CountryModel.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import Foundation

struct Country: Decodable {
    
    let capital: [String]?
    let region: String
    let subregion: String?
    let continents: [String]
    let landlocked: Bool
    let area: Double
    let borders: [String]?
    let flag: String
    let altSpellings: [String]
    let population: Int
    let timezones: [String]
    let startOfWeek: String
    let fifa: String?
    let flags: Flags
    let maps: Maps
}

struct Flags: Decodable {
    
    let png: String
    let svg: String
    let alt: String?
}

struct Maps: Decodable {
    
    let googleMaps: String
    let openStreetMaps: String
}
