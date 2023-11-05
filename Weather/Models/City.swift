//
//  City.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation

// MARK: - CityElement
struct CityElement: Codable {
    let name: String
  //  let localNames: [String: String]
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        
        case lat, lon, country, state
    }
}

typealias Cities = [CityElement]
