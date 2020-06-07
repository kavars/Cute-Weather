//
//  WeatherID.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 07.06.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class WeatherID: WeatherViewDelegate {
    
    init(id: Int) {
        cityID = id
    }

    var cityID: Int
    let networking = Networking()
    
    func getWeather(_ weatherView: WeatherView, completion: (() -> Void)?) {
        
        networking.performNetworkTask(endpoint: OpenWeatherAPI.cityID(id: cityID), type: WeatherResponse.self) { response in
            weatherView.city = response
            
            completion?()
        }
    }
    
    func refreshControlHandler(_ weatherView: WeatherView, completion: (() -> Void)?) {
        getWeather(weatherView, completion: completion)
    }
}
