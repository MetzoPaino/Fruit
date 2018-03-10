//
//  FruitDetailPresenter.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation

class FruitDetailPresenter {

    private var fruitDetailView : FruitDetailView?

    func attachView(_ view: FruitDetailView) {
        fruitDetailView = view
    }
}
