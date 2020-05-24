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
    let urlComponents: URLComponents
    
    init(urlComponents: URLComponents) {
        self.urlComponents = urlComponents
    }
    
    func get<T: Decodable>(with urlComponents: URLComponents, responseDataHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }

        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: \(error)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let responseData = try decoder.decode(T.self, from: data)
                    responseDataHandler(.success(responseData))
                } catch {
                    responseDataHandler(.failure(.message("Error to decode response data")))
                }
                
            }
        }
        
        dataTask.resume()
    }
}
