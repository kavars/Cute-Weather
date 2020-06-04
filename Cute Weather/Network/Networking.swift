//
//  Networking.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 26.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

struct Networking {
    
    func performNetworkTask<T: Codable>(endpoint: EndpointType, type: T.Type, completion: ((_ response: T) -> Void)?) {
        
        let url = endpoint.fullURL
        let urlRequest = URLRequest(url: url)
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("Data is nil")
                return
            }
            
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                print("Problem with data decode")
                return
            }
            completion?(decoded)
        }
        
        urlSession.resume()
    }
    
}
