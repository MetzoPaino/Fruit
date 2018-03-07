//
//  AppDelegate.swift
//  Fruit
//
//  Created by William Robinson on 06/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let downloadManger = DownloadManager()
    let coreDataManager = CoreDataManager()

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "FruitModel")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        coreDataManager.coreDataStack = coreDataStack

        if coreDataManager.shouldDownloadData() {
            downloadManger.downloadData(completionHandler: { data in
                self.coreDataManager.writeData(data)
            })
        }

        guard let navController = window?.rootViewController as? UINavigationController,
            let viewController = navController.topViewController as? FruitListTableViewController else {
                return true
        }

        viewController.coreDataStack = coreDataStack

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
}

