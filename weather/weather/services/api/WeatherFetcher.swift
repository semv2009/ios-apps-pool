//
//  WeatherManager.swift
//  weather
//
//  Created by Artyom Burkan on 16.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import Foundation

class WeatherFetcher {
    let httpRequest: HttpRequest
    
    init() {
        httpRequest = HttpRequest(baseUrl: "https://api.openweathermap.org/data/2.5")
    }
    
    func fetchCityWeather(at city: String, responseDataHandler: @escaping (Result<Weather, RequestError>) -> Void) {
        httpRequest.get(path: "/weather", params: "q=\(city)", responseDataHandler: responseDataHandler)
                
        print("urlRequest: \(city)")
    }
}
