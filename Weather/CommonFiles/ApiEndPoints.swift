//
//  ApiEndPoints.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation


final class WeatherRequestUrl{
    static let shared = WeatherRequestUrl()
    private struct Constants{
        public static let baseUrl = "https://api.openweathermap.org"
        public static let appId = "1362e3454c243cb743ee75481231465b"
        public static let weatherIcon = "https://openweathermap.org/img/wn/%@@2x.png"
        
    }
    func getCoordinatesUrl(fromCity city:String)->URL?{
        let urlString = String(format: "%@/geo/1.0/direct?q=%@&limit=2&appid=%@", Constants.baseUrl, city,Constants.appId)
        return URL(string: urlString)
        
    }
    func getDailyWeatherUrl(from coord:Coord)->URL?{
        let urlString = String(format: "%@/data/2.5/forecast/daily?lat=%.5f&lon=%.5f&cnt=7&units=metric&appid=%@", Constants.baseUrl, coord.lat, coord.lon, Constants.appId)
        return URL(string: urlString)
    }
    func getImageUrl(from icon:String)->URL?{
        let urlString = String(format: Constants.weatherIcon, icon)
        return URL(string: urlString)
    }
}


