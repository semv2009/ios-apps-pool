//
//  RequestService.swift
//  weather
//
//  Created by Artyom Burkan on 16.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case message(String)
}

class HttpRequest {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func get<T: Decodable>(path: String, params: String, responseDataHandler: @escaping (Result<T, RequestError>) -> Void) {
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
                    let responseData = try decoder.decode(T.self, from: data)
                    print("response data: \(responseData)")
                    responseDataHandler(.success(responseData))
                } catch {
                    print("Error to decode response data \(error)")
                    responseDataHandler(.failure(.message("Error to decode response data")))
                }
                
            }
        }

        dataTask.resume()
    }
}


// api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
