//
//  CityIDAPI.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 02.06.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

enum CityIDAPI {
    case cityName(name: String)
}

extension CityIDAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "your server IP")! // Enter your server IP
    }
    
    var fullURL: URL {
        switch self {
        case .cityName(let name):
            var urlComponents = URLComponents(string: baseURL.absoluteString)!
            
            urlComponents.queryItems = [
                URLQueryItem(name: "name", value: "\(name)"),
            ]
            
            return urlComponents.url!
        }
    }
}
