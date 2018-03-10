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

    @NSManaged var price: Int
    @NSManaged var type: String
    @NSManaged var weight: Int

    let fruitEntityName: NSString = "Fruit"

    class func fetchRequest() -> NSFetchRequest<Fruit> {
        return NSFetchRequest<Fruit>(entityName: "Fruit")
    }
}

extension Fruit {

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
