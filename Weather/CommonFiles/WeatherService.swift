//
//  WeatherService.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
enum ServiceError:Error{
    case invalidDataError
    case dataParsingError
    case invalidUrlError
    var localizedDescription: String {
        switch self {
        case .invalidDataError:
            return "Data is invalid"
        case .dataParsingError:
            return "Error in data parsing"
        case .invalidUrlError:
            return "invalid Url"
        }
    }
}
import Foundation
protocol Service{
    func execute<T:Codable>(requestUrl:URL, expecting type:T.Type) async throws -> T
}
final class WeatherService:Service{
    
    
    public func execute<T:Codable>(requestUrl:URL, expecting type:T.Type) async throws -> T{
        print(requestUrl)
        let (data, _) = try await URLSession.shared.data(from: requestUrl)
        
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "Failed to serialize JSON.")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(type, from: data)
    }
}
