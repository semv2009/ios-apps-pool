//
//  WeatherManager.swift
//  weather
//
//  Created by Artyom Burkan on 16.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import Foundation

class WeatherApi {
    let httpRequest: HttpRequest
    
    init() {
        httpRequest = HttpRequest(baseUrl: "https://api.openweathermap.org/data/2.5")
    }
    
    func fetchWeather(city: String) {
        httpRequest.get(path: "/weather", params: "q=\(city)") { weatherData in
            switch weatherData {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print("Source of randomness failed: \(error)")
            }
        }
        
        
        print("urlRequest: \(city)")
    }
}
