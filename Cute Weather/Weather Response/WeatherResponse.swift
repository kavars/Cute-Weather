//
//  WeatherResponse.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 26.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coord
        
    struct Coord: Codable {
        let lon: Double?
        let lat: Double?
    }
    
    let weather: [Weather]
    
    struct Weather: Codable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }
    
    let base: String?
    
    let main: Main
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        
        let sea_level: Int?
        let grnd_level: Int?
    }
    
    let visibility: Int?
    
    let wind: Wind
    
    struct Wind: Codable {
        let speed: Double?
        let deg: Double?
    }
    
    let clouds: Clouds?
    
    struct Clouds: Codable {
        let all: Int?
    }
    
    let rain: Rain?
    
    struct Rain: Codable {
        let h1: Double?
        let h3: Double?
        
        private enum CodingKeys: String, CodingKey {
            case h1 = "1h"
            case h3 = "3h"
        }
    }
    
    let snow: Snow?
    
    struct Snow: Codable {
        let h1: Double?
        let h3: Double?
        
        private enum CodingKeys: String, CodingKey {
            case h1 = "1h"
            case h3 = "3h"
        }
    }
    
    let dt: Int?
    
    let sys: Sys
    
    struct Sys: Codable {
        let type: Int?
        let id: Int?
        let message: Double?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    let timezone: Int?
    let id: Int?
    let name: String
    let cod: Int?
}
