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
    let temperature: String
    let description: String

    private let weatherId: Int
    
    var weatherIconName: String {
        get {
            switch weatherId {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case main
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)

        let main = try container.decode(WeatherMain.self, forKey: .main)
        temperature = String(Int(main.temperature.rounded()))
        
        let weather = try container.decode([WeatherDescription].self, forKey: .weather)
        description = weather[0].description
        weatherId = weather[0].weatherId
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
    let weatherId: Int
    
    enum CodingKeys: String, CodingKey {
        case description
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        weatherId = try container.decode(Int.self, forKey: .id)
    }
}
