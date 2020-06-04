//
//  OpenWeatherAPI.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 26.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

enum OpenWeatherAPI {
    case cityID(id: Int)
    case coords(lat: Double, lon: Double)
    
    var apiKey: String {
        return "your API key" // Enter your OpenWeatherMap API key
    }
}

extension OpenWeatherAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    }
    
    var fullURL: URL {
        switch self {
        case .cityID(let id):
            var urlComponents = URLComponents(string: baseURL.absoluteString)!
            
            urlComponents.queryItems = [
                URLQueryItem(name: "id", value: "\(id)"),
                URLQueryItem(name: "appid", value: "\(apiKey)")
            ]
            
            return urlComponents.url!
            
        case .coords(let lat, let lon):
            var urlComponents = URLComponents(string: baseURL.absoluteString)!
            
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: "\(apiKey)")
            ]
            
            return urlComponents.url!
        }
    }
}
