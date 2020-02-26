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

    var coreDataManager: CoreDataManager!
    var validFruitDictionary: Dictionary<String, Any>!
    var invalidFruitDictionary: Dictionary<String, Any>!

    var correctType: String!
    var correctWeight: Int!
    var correctPrice: Int!

    var incorrectType: Int!
    var incorrectWeight: String!
    var incorrectPrice: Double!

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager()

        let typeKey = "type"
        let weightKey = "weight"
        let priceKey = "price"

        correctType = "Orange"
        correctWeight = 100
        correctPrice = 500

        incorrectType = 7575
        incorrectWeight = "Heavy"
        incorrectPrice = 10.56

        validFruitDictionary = Dictionary()
        validFruitDictionary[typeKey] = correctType
        validFruitDictionary[weightKey] = correctWeight
        validFruitDictionary[priceKey] = correctPrice

        invalidFruitDictionary = Dictionary()
        invalidFruitDictionary[typeKey] = incorrectType
        invalidFruitDictionary[weightKey] = incorrectWeight
        invalidFruitDictionary[priceKey] = incorrectPrice
    }
    
    override func tearDown() {
        super.tearDown()

        coreDataManager = nil
        validFruitDictionary = nil
        invalidFruitDictionary = nil

        correctType = nil
        correctWeight = nil
        correctPrice = nil

        incorrectType = nil
        incorrectWeight = nil
        incorrectPrice = nil
    }
    
    func testDictionaryToFruit() {

        let validFruit = Fruit(context: coreDataManager.coreDataStack.managedContext)
        do {
            try validFruit.dictionaryToFruit(dictonary: validFruitDictionary)
        } catch {
            XCTFail("Failed to create Fruit")
        }

        XCTAssert(validFruit.type == correctType)
        XCTAssert(validFruit.weight == correctWeight)
        XCTAssert(validFruit.price == correctPrice)

        let failureFruit = Fruit(context: coreDataManager.coreDataStack.managedContext)
        var caught = false
        do {
            try failureFruit.dictionaryToFruit(dictonary: invalidFruitDictionary)
        } catch {
            caught = true
        }
        XCTAssertFalse(caught)
    }
}
