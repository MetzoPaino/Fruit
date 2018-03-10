//
//  FruitListPresenter.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation
import CoreData

class FruitListPresenter: NSObject {

    //MARK: - Variables

    private var fruitListView : FruitListView?
    private var fetchedResultsController: NSFetchedResultsController<Fruit>!

    //MARK: - Life Cycle

    override init() {
        super.init()
        fetchedResultsController = AppManager.sharedInstance.fetchedResultsController()
        fetchedResultsController.delegate = self
    }

    func attachView(_ view: FruitListView) {
        fruitListView = view
    }

    func performFetch() {

        do {
            try fetchedResultsController.performFetch()
            fruitListView?.updateFruits(fruits: fetchedResultsController.fetchedObjects)
            
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }

    func refreshList() {
        AppManager.sharedInstance.downloadData(forced: true)
        
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FruitListPresenter: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        print("controllerWillChangeContent")
        // TODO: - Test this, can i update the data model before begin updates?
        fruitListView?.updateFruits(fruits: fetchedResultsController.fetchedObjects)
        fruitListView?.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // TODO: - Test this
        print("controllerDidChangeContent")
        fruitListView?.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("controller didChange anObject at indexPath")
        fruitListView?.updateFruits(fruits: fetchedResultsController.fetchedObjects)
    }
}
