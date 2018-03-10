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

    private let downloadManger = DownloadManager()
    private let coreDataManager = CoreDataManager()

    struct Static {
        static var instance: AppManager?
    }

    class var sharedInstance : AppManager {

        if Static.instance == nil {
            Static.instance = AppManager()
        }
        return Static.instance!
    }

    func downloadData(forced: Bool) {

        if forced {
            coreDataManager.purgeFruitFromDatabase()
        } else if !coreDataManager.shouldDownloadData() {
            return
        }

        downloadManger.downloadData(completionHandler: { data, error in

            if let data = data {

                do {
                    try self.coreDataManager.save(fruitArray: data)
                } catch {
                    print("Failed to save!")
                }

            } else {
                print("No Data!")
            }
        })
    }

    func fetchedResultsController() ->  NSFetchedResultsController<Fruit> {
        return coreDataManager.fetchedResultsController
    }
}
