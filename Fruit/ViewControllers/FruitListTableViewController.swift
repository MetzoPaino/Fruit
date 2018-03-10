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


    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.performFetch()

        title = NSLocalizedString("FruitListTableViewControllerTitle", comment: "")
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

    func beginUpdates() {
        print("FruitListTableViewController: beginUpdates")
//        tableView.beginUpdates()
    }

    func endUpdates() {
        print("FruitListTableViewController: endUpdates")
//        tableView.endUpdates()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

//extension FruitListTableViewController: NSFetchedResultsControllerDelegate {
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch (type) {
//        case .insert:
//            if let indexPath = newIndexPath {
//                tableView.insertRows(at: [indexPath], with: .automatic)
//            }
//            break;
//        case .delete:
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            break;
//        case .update:
//            if
//                let indexPath = indexPath,
//                let cell = tableView.cellForRow(at: indexPath) as? FruitTableViewCell {
//                    let fruit = fetchedResultsController.object(at: indexPath)
//                    cell.setup(fruit: fruit)
//            }
//            break;
//        case .move:
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//
//            if let newIndexPath = newIndexPath {
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
//            break;
//        }
//    }
//}
