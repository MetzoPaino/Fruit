//
//  Fruit.swift
//  Fruit
//
//  Created by William Robinson on 06/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

class Fruit: NSObject {

    var price: String
    var type: String
    var weight: String

    init?(type: String, price: String, weight: String) {

        self.type = type
        self.price = price
        self.weight = weight
    }
}
