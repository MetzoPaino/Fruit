//
//  FruitListTableViewController.swift
//  Fruit
//
//  Created by William Robinson on 06/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit
import CoreData

class FruitListTableViewController: UITableViewController  {

    //MARK: - Variables

    private var presenter = FruitListPresenter()
    private var fruits = [Fruit]()
    private let cellIdentifier = "Cell"
    private let pushSegueIdentifier = "PushFruitDetail"

    private var analyticDate: Date?

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.performFetch()

        title = NSLocalizedString("FruitListTableViewControllerTitle", comment: "")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        analyticDate = Date()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let analyticDate = analyticDate {
            presenter.sendDisplayTimeAnalytic(timeTaken: Date().timeIntervalSince(analyticDate))
            self.analyticDate = nil
        }
    }

    // MARK: - IBActions

    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        presenter.refreshList()
    }

    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FruitDetailsViewController {

            if let indexPath = tableView.indexPathForSelectedRow {
                controller.fruit =  fruits[indexPath.row]
            } else {
                controller.fruit = Fruit()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FruitTableViewCell else {
            return UITableViewCell()
        }

        let fruit = fruits[indexPath.row]
        cell.setup(fruit: fruit)

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: pushSegueIdentifier, sender: self)
    }
}

extension FruitListTableViewController: FruitListView {

    func updateFruits(fruits: [Fruit]?) {

        print("FruitListTableViewController: updateFruits")
        if let fruits = fruits {
            self.fruits = fruits
        }
        tableView.reloadData()
    }
}
