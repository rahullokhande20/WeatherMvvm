//
//  Weather.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - List
struct List: Codable {
    let dt:Date
    let sunrise, sunset: Date
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [WeatherElement]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds:Int
    let pop: Double

   /* enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, gust, clouds, pop
    }*/
    var formattedDate: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd-MMM-yyyy"
           return dateFormatter.string(from: dt)
    }
    var sunriseFormatted: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "hh:mm e"
           return dateFormatter.string(from: sunrise)
    }
    var sunsetFormatted: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "hh:mm e"
           return dateFormatter.string(from: sunset)
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, description, icon: String
}
