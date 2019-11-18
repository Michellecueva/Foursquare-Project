//
//  Foursquare_ProjectTests.swift
//  Foursquare-ProjectTests
//
//  Created by Michelle Cueva on 11/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import XCTest
@testable import Foursquare_Project

class Foursquare_ProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func SearchQueryModel() -> Data? {
            let bundle = Bundle(for: type(of: self))
            guard let pathToData = bundle.path(forResource: "SearchSample", ofType: ".json")  else {
                XCTFail("couldn't find Json")
                return nil
            }
            let url = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch let error {
                fatalError("couldn't find data \(error)")
            }
        }
    
    func testQueryModel () {
            let data = SearchQueryModel() ?? Data()
            
            do {
                let searchData = Location.getQuery(from: data)
                
                 XCTAssertTrue(searchData.count > 0, "model was not loaded")
            } 
    }
}
