//
//  WeatherViewProtocol.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 07.06.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherViewDelegate: AnyObject {
    func getWeather(_ weatherView: WeatherView, completion: (() -> Void)?)

    func refreshControlHandler(_ weatherView: WeatherView, completion: (() -> Void)?)
}
