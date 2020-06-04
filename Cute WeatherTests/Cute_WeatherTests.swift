//
//  Cute_WeatherTests.swift
//  Cute WeatherTests
//
//  Created by Kirill Varshamov on 26.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import XCTest
@testable import Cute_Weather

class Cute_WeatherTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
                
        let decoder = JSONDecoder()
        

        
        self.measure {
            do {
                let path = Bundle.main.path(forResource: "city.list", ofType: "json")
                if let path = path {
                    let json = try String(contentsOfFile: path, encoding: .utf8)
                    let data = json.data(using: .utf8)!
                    
                    let _ = try decoder.decode([CityCell].self, from: data)
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        
    }

}
