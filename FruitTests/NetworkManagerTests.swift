//
//  NetworkManagerTests.swift
//  FruitTests
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import XCTest
@testable import Fruit

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var validURLString: String!
    var invalidURLString: String!
    
    override func setUp() {
        super.setUp()

        networkManager = NetworkManager()
        validURLString = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
        invalidURLString = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data. json"
    }
    
    override func tearDown() {
        super.tearDown()

        networkManager = nil
        validURLString = nil
        invalidURLString = nil
    }

    func testCreateURL() {

        XCTAssertNoThrow(try networkManager.createURL(string: validURLString))
        XCTAssertThrowsError(try networkManager.createURL(string: invalidURLString))
    }
}
