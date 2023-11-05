//
//  ProfileViewModel.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
class ProfileViewModel{
    var user:User
    var city:String
    private let requestHandler:HttpRequestHandlerProtocol
    @Published var alert: (title: String, message: String)?
    @Published var weather:Weather?
    init(requestHandler:HttpRequestHandlerProtocol = HttpRequestHandler(), user:User){
        self.requestHandler = requestHandler
        self.user = user
        self.city = ""
    }
    func fetchWeatherDetails(){
        Task {
            do{
            let coord = try await requestHandler.getCoordinates(from:city)
                weather = try await requestHandler.getWeather(from: coord)
                print(weather)
               // print(weather?.list[0].formattedDate ?? "")
            } catch{
                
                print(error.localizedDescription)
                alert = ("Error",error.localizedDescription)
            }
        }
        
    }
    
}
