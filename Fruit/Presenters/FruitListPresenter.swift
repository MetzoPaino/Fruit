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

    func sendDisplayTimeAnalytic(timeTaken: TimeInterval) {
        AppManager.sharedInstance.sendAnalyticDisplayEvent(timeTaken: timeTaken)
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FruitListPresenter: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("controller didChange anObject at indexPath")
        fruitListView?.updateFruits(fruits: fetchedResultsController.fetchedObjects)
    }
}
