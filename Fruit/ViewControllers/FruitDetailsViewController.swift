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

    private let britishLocale = Locale(identifier: "en_gb")

    var fruit: Fruit!
    private var presenter = FruitDetailsPresenter()

    private var weightString: String {

        let pounds = Measurement(value: Double(fruit.weight), unit: UnitMass.pounds)
        let kilograms = pounds.converted(to: UnitMass.kilograms)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .naturalScale
        formatter.locale = britishLocale
        return formatter.string(from: kilograms)
    }

    private var priceString: String {

        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = britishLocale
        let pennies = Double(fruit.price) / 100

        if let string = currencyFormatter.string(from: NSNumber(value: pennies)) {
            return string
        }
        return ""
    }

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        style()
    }

    //MARK: - Style

    func style() {
        title =  fruit.type.capitalized
        weightLabel.text = NSLocalizedString("FruitDetailsWeight", comment: "") + " " + "\(weightString)"
        priceLabel.text = NSLocalizedString("FruitDetailsPrice", comment: "") + " " + "\(priceString)"
    }
}

extension FruitDetailsViewController: FruitDetailsView {}
