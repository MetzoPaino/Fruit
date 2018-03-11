//
//  Fruit.swift
//  Fruit
//
//  Created by William Robinson on 06/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit
import CoreData

enum FruitError: Error {
    case dictionaryCreation
}

class Fruit: NSManagedObject {

    /// The price of the fruit in pennies for GBP
    @NSManaged var price: Int

    /// The name of the fruit
    @NSManaged var type: String

    /// The weight of the fruit in pounds
    @NSManaged var weight: Int

    class func fetchRequest() -> NSFetchRequest<Fruit> {
        return NSFetchRequest<Fruit>(entityName: "Fruit")
    }
}

extension Fruit {

    /**
     Sets the variables of Fruit from a Dictionary

     - Parameters:
     - Dictionary: Dictionary created from API JSON

     ```
     // Dictionary example:
     let dictionary = [
        "type": "Orange",
        "weight": 100,
        "price": 30
     ]
     ```
     */
    func dictionaryToFruit(dictonary: Dictionary<String, Any>) throws {

        if
            let type = dictonary["type"] as? String,
            let weight = dictonary["weight"] as? Int,
            let price = dictonary["price"] as? Int {

            self.type = type
            self.weight = weight
            self.price = price
        } else {
            throw FruitError.dictionaryCreation
        }
    }
}
