//
//  RequestService.swift
//  weather
//
//  Created by Artyom Burkan on 16.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case weatherErrorMessage
}

protocol HttpMethods {
    func get(path: String, params: String, responseDataHandler: @escaping (Result<Weather, WeatherError>) -> Void)
}

class HttpRequest: HttpMethods {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func get(path: String, params: String, responseDataHandler: @escaping (Result<Weather, WeatherError>) -> Void) {
        let urlString = "\(baseUrl)\(path)?appid=\(API_KEY)&units=metric&\(params)"
        print(urlString)

        guard let url = URL(string: urlString) else { fatalError("URL object is'n valid") }

        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: \(error)")
                return
            }

            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let weather = try decoder.decode(Weather.self, from: data)
                    print("weather: \(weather)")
                    responseDataHandler(.success(weather))
                } catch {
                    print("Error to decode weather object \(error)")
                    responseDataHandler(.failure(.weatherErrorMessage))
                }
                
            }
        }

        dataTask.resume()
    }
}


// api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
