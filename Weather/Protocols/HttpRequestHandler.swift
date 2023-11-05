//
//  HttpRequestHandler.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
protocol HttpRequestHandlerProtocol{
    func getCoordinates(from cityName:String) async throws -> Coord
    func getWeather(from coordinates:Coord) async throws-> Weather
    
}

class HttpRequestHandler:HttpRequestHandlerProtocol{
    let service:Service
    init(service:Service = WeatherService()){
        self.service = service
    }
    func getCoordinates(from cityName: String) async throws -> Coord {
        print(cityName," city")
        guard let url = WeatherRequestUrl.shared.getCoordinatesUrl(fromCity: cityName)
        else { throw ServiceError.invalidUrlError }
        let cities = try await service.execute(requestUrl: url, expecting: Cities.self)
        guard cities.count > 0 else {
            throw ServiceError.invalidDataError
        }
        let city = cities[0]
        let coord = Coord(lon: city.lon, lat: city.lat)
        return coord
        
    }
    
    func getWeather(from coordinates: Coord) async throws -> Weather {
        guard let url = WeatherRequestUrl.shared.getDailyWeatherUrl(from: coordinates)
        else { throw ServiceError.invalidUrlError }
        return try await service.execute(requestUrl: url, expecting: Weather.self)
    }
}
