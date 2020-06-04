//
//  File.swift
//  
//
//  Created by Kirill Varshamov on 02.06.2020.
//

import Foundation

func parseDataBase() -> [City] {
    let decoder = JSONDecoder()
    
    var cities: [City] = [City]()
    
    do {
        let json = try String(contentsOfFile: "your path to the city.list.json", encoding: .utf8) // add path to the city.list.json
        let data = json.data(using: .utf8)!
        
        cities = try decoder.decode([City].self, from: data)
        print("Parse OK")
    } catch {
        fatalError(error.localizedDescription)
    }
    
    return cities
}





