//
//  FruitDetailsViewController.swift
//  Fruit
//
//  Created by William Robinson on 06/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

class FruitDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private var weightLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    //MARK: - Variables
    var fruit: Fruit!

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }

    func style() {

        title =  fruit.type.capitalized
        weightLabel.text = "\(fruit.weight)"
        priceLabel.text = "\(fruit.price)"
    }
}
