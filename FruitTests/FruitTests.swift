//
//  FruitTests.swift
//  FruitTests
//
//  Created by William Robinson on 08/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import XCTest
@testable import Fruit

class FruitTests: XCTestCase {

    let coreDataManager = CoreDataManager()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDictionaryToFruit() {

        var dictionary = Dictionary<String, Any>()
        dictionary["type"] = "Orange"
        dictionary["weight"] = 100
        dictionary["price"] = 500

        let fruit = Fruit(context: coreDataManager.coreDataStack.managedContext)
        do {
            try fruit.dictionaryToFruit(dictonary: dictionary)
        } catch {
            XCTFail("Didn't expect the fruit exception man")
        }

        XCTAssert( fruit.type == "Orange")
        XCTAssert( fruit.weight == 100)
        XCTAssert( fruit.price == 500)

        dictionary["type"] = 7575
        dictionary["weight"] = "100"
        dictionary["price"] = 10.56

        let failureFruit = Fruit(context: coreDataManager.coreDataStack.managedContext)
        var caught = false
        do {
            try failureFruit.dictionaryToFruit(dictonary: dictionary)
        } catch {
            caught = true
        }
        XCTAssert(caught)
    }
}
