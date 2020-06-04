//
//  main.swift
//  Cute Weather City ID
//
//  Created by Kirill Varshamov on 01.06.2020.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer

import Foundation

let cities: [City] = parseDataBase()

// This 'handler' function can be referenced directly in the configuration below.
func handler(request: HTTPRequest, response: HTTPResponse) {
    
    if let name = request.param(name: "name") {
        
        var citiesResponse: [City] = [City]()
        
        for city in cities {
            if city.name.contains(string: name) {
                citiesResponse.append(city)
            }
            
            if citiesResponse.count > 10 {
                break
            }
        }
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(citiesResponse)
            
            response.setBody(bytes: Array(jsonData))
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
	response.completed()
}

// Configure one server which:
//	* Serves the hello world message at <host>:<port>/
//	* Serves static files out of the "./webroot"
//		directory (which must be located in the current working directory).
//	* Performs content compression on outgoing data when appropriate.
var routes = Routes()
routes.add(method: .get, uri: "/", handler: handler)
routes.add(method: .get, uri: "/**",
		   handler: StaticFileHandler(documentRoot: "./webroot", allowResponseFilters: true).handleRequest)
try HTTPServer.launch(name: "localhost",
					  port: 8181,
					  routes: routes,
					  responseFilters: [
						(PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])

