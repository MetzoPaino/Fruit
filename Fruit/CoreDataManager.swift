//
//  CoreDataManager.swift
//  Fruit
//
//  Created by William Robinson on 07/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    var coreDataStack: CoreDataStack!

    func shouldDownloadData() -> Bool {

        let fruitFetchRequest: NSFetchRequest<Fruit> = Fruit.fetchRequest()
        let fruitCount = try? coreDataStack.managedContext.count(for: fruitFetchRequest)

        if let fruitCount = fruitCount, fruitCount > 0 {
            return false
        }
        return true
    }

    func writeData(_ data : Data) {

        do {
            if
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any],
                let jsonArray =  jsonDictionary["fruit"] as? [[String: Any]] {

                for fruitDictionary in jsonArray {

                    let fruit = Fruit(context: coreDataStack.managedContext)

                    if
                        let type = fruitDictionary["type"] as? String,
                        let weight = fruitDictionary["weight"] as? Int,
                        let price = fruitDictionary["price"] as? Int {

                        fruit.type = type
                        fruit.weight = weight
                        fruit.price = price
                    }
                }
                coreDataStack.saveContext()
            }

        } catch let error as NSError {
            print("Error writing fruits: \(error)")
        }
    }
}
