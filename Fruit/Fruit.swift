//
//  Fruit.swift
//  Fruit
//
//  Created by William Robinson on 06/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit
import CoreData

//    var weight: Measurement<UnitMass> {
//
//        get {
//            willAccessValue(forKey: "primativeWeight")
//            defer { didAccessValue(forKey:"primativeWeight") }
//
//            let pounds = Measurement(value: Double(primativeWeight), unit: UnitMass.pounds)
//
//            let grams = pounds.converted(to: UnitMass.grams)
//
//            return grams
//        }
//        set {
//            willChangeValue(forKey:"primativeWeight")
//            defer { didChangeValue(forKey:"primativeWeight") }
//
//            let intValue = NSNumber(value: Int(newValue.value))
//            primativeWeight = intValue.intValue
//        }
//    }

class Fruit: NSManagedObject {

    @NSManaged var price: Int
    @NSManaged var type: String
    @NSManaged var weight: Int

    class func fetchRequest() -> NSFetchRequest<Fruit> {
        return NSFetchRequest<Fruit>(entityName: "Fruit")
    }
}
