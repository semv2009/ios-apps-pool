//
//  WeatherManager.swift
//  weather
//
//  Created by Artyom Burkan on 16.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import Foundation

class WeatherFetcher {
    private let httpRequest = HttpRequest(urlComponents: URLComponents())
    
    private func createUrlComponents(to path: String, for urlQueryItems: [URLQueryItem]) -> URLComponents {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: API_KEY),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        urlQueryItems.forEach { urlQueryItem in
            urlComponents.queryItems?.append(urlQueryItem)
        }

        urlComponents.path = "/data/2.5/weather"
        
        return urlComponents
    }
    
    func fetchByCityName(at city: String, responseDataHandler: @escaping (Result<Weather, RequestError>) -> Void) {
        let urlQueryItem = URLQueryItem(name: "q", value: city)
        let path = "/data/2.5/weather"
        let urlComponents = createUrlComponents(to: path, for: [urlQueryItem])
        
        httpRequest.get(with: urlComponents, responseDataHandler: responseDataHandler)
    }
    
    func fetchByGeographicCoordinates(latitude lat: String, longitude lon: String, responseDataHandler: @escaping (Result<Weather, RequestError>) -> Void) {
        let urlQueryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon)
        ]
        let path = "/data/2.5/weather"
        let urlComponents = createUrlComponents(to: path, for: urlQueryItems)
        
        httpRequest.get(with: urlComponents, responseDataHandler: responseDataHandler)
    }
}
