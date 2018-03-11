//
//  AppManager.swift
//  Fruit
//
//  Created by William Robinson on 08/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit
import CoreData

class AppManager {

    // MARK:- Variables

    private let networkManger = NetworkManager()
    private let coreDataManager = CoreDataManager()
    private let analyticsManager = AnalyticsManager()

    struct Static {
        static var instance: AppManager?
    }

    class var sharedInstance : AppManager {

        if Static.instance == nil {
            Static.instance = AppManager()
        }
        return Static.instance!
    }

    // MARK:- Network Manager

    func downloadData(forced: Bool) {

        if forced {
            coreDataManager.purgeFruitFromDatabase()
        } else if !coreDataManager.shouldDownloadData() {
            return
        }

        networkManger.downloadData(completionHandler: { data, timeTaken, error in

            if let timeTaken = timeTaken {
                self.sendAnalyticLoadEvent(timeTaken: timeTaken)
            }

            if let error = error {
                print("Failed to download data \(error)")
            }

            guard let data = data else {
                return
            }

            do {
                try self.coreDataManager.save(fruitArray: data)
            } catch {
                print("Failed to save data")
            }
        })
    }

    // MARK:- Analytics

    func sendAnalyticLoadEvent(timeTaken: TimeInterval) {
        networkManger.postAnalytic(urlComponents: analyticsManager.loadEvent(timeTaken: timeTaken))
    }

    func sendAnalyticDisplayEvent(timeTaken: TimeInterval) {
        networkManger.postAnalytic(urlComponents: analyticsManager.displayEvent(timeTaken: timeTaken))
    }

    func sendAnalyticErrorEvent(exception: NSException) {
        networkManger.postAnalytic(urlComponents: analyticsManager.errorEvent(exception: exception))
    }

    // MARK:- Core Data

    func fetchedResultsController() ->  NSFetchedResultsController<Fruit> {
        return coreDataManager.fetchedResultsController
    }
}
