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
    var validURLComponents: URLComponents!

    override func setUp() {
        super.setUp()

        networkManager = NetworkManager()

        validURLComponents = URLComponents()
        validURLComponents.scheme = "https"
        validURLComponents.host = "raw.githubusercontent.com"
        validURLComponents.path = "/fmtvp/recruit-test-data/master/data.json"
    }
    
    override func tearDown() {
        super.tearDown()

        networkManager = nil
        validURLComponents = nil
    }

    func testCreateURL() {
        XCTAssertNoThrow(try networkManager.createURL(urlComponents: validURLComponents))
    }
}
