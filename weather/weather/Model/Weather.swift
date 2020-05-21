//
//  Weather.swift
//  weather
//
//  Created by Artyom Burkan on 19.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let name: String
    let temperature: Double
    let description: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case main
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)

        let main = try container.decode(WeatherMain.self, forKey: .main)
        temperature = main.temperature
        
        let weather = try container.decode([WeatherDescription].self, forKey: .weather)
        description = weather[0].description
    }
}

struct WeatherMain: Decodable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(Double.self, forKey: .temp)
    }
}

struct WeatherDescription: Decodable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
    }
}
