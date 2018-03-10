//
//  CoreDataManager.swift
//  Fruit
//
//  Created by William Robinson on 07/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {

    private let modelName = "FruitModel"
    lazy var coreDataStack = CoreDataStack(modelName: modelName)

    lazy var fetchedResultsController: NSFetchedResultsController<Fruit> = {
        let fetchRequest: NSFetchRequest<Fruit> = Fruit.fetchRequest()
        let nameSort = NSSortDescriptor(key: #keyPath(Fruit.type), ascending: true)
        fetchRequest.sortDescriptors = [nameSort]

        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: "Fruits")

        return fetchedResultsController
    }()

    func shouldDownloadData() -> Bool {

        let fruitFetchRequest: NSFetchRequest<Fruit> = Fruit.fetchRequest()
        let fruitCount = try? coreDataStack.managedContext.count(for: fruitFetchRequest)

        if let fruitCount = fruitCount, fruitCount > 0 {
            return false
        }
        return true
    }

    func save(fruitArray: [[String: Any]]) throws {
        for fruitDictionary in fruitArray {
            let fruit = Fruit(context: coreDataStack.managedContext)
            do {
                try fruit.dictionaryToFruit(dictonary: fruitDictionary)
            } catch {
                coreDataStack.managedContext.delete(fruit)
            }
        }

        coreDataStack.saveContext()
    }

    func purgeFruitFromDatabase() {
        let fetchRequest: NSFetchRequest<Fruit> = Fruit.fetchRequest()
        fetchRequest.includesPropertyValues = false
        do {
            let items = try coreDataStack.managedContext.fetch(fetchRequest)
            for item in items {
                coreDataStack.managedContext.delete(item)
            }
        } catch {
            print("Could not clear data: \(error)")
        }
    }
}
