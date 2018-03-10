//
//  FruitTableViewCell.swift
//  Fruit
//
//  Created by William Robinson on 07/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

class FruitTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet private var nameLabel: UILabel!

    //MARK: - Setup

    func setup(fruit:Fruit) {

        var name = fruit.type.capitalized

        if let emoji = emojiDictionary[fruit.type.lowercased()] {
            name += " " + emoji
        }
        nameLabel.text = name
    }
}
