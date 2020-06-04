//
//  EndpointType.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 26.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
        
    var fullURL: URL { get }
}
