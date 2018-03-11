//
//  FruitDetailPresenter.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation

class FruitDetailsPresenter {

    private var fruitDetailsView : FruitDetailsView?

    func attachView(_ view: FruitDetailsView) {
        fruitDetailsView = view
    }

    func sendDisplayTimeAnalytic(timeTaken: TimeInterval) {
        AppManager.sharedInstance.sendAnalyticDisplayEvent(timeTaken: timeTaken)
    }
}
