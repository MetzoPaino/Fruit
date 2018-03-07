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
    var coreDataStack: CoreDataStack!

    lazy var fetchedResultsController: NSFetchedResultsController<Fruit> = {
        let fetchRequest: NSFetchRequest<Fruit> = Fruit.fetchRequest()
        let nameSort = NSSortDescriptor(key: #keyPath(Fruit.type), ascending: true)
        fetchRequest.sortDescriptors = [nameSort]

        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: "Fruits")

        return fetchedResultsController
    }()

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("FruitListTableViewControllerTitle", comment: "")

        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }

//        UITableView.appearance().separatorInset = .zero
//         UITableView.appearance().tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let fetchedObjects = fetchedResultsController.fetchedObjects else {
            return 0
        }
        return fetchedObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FruitTableViewCell else {
            return UITableViewCell()
        }

        let fruit = fetchedResultsController.object(at: indexPath)
        cell.setup(fruit: fruit)

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PushFruitDetail", sender: self)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FruitDetailsViewController {

            if let indexPath = tableView.indexPathForSelectedRow {
                controller.fruit = fetchedResultsController.object(at: indexPath)
            } else {
                controller.fruit = Fruit()
            }
        }
    }

}

// MARK: - NSFetchedResultsControllerDelegate

extension FruitListTableViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            break;
        case .update:
            if
                let indexPath = indexPath,
                let cell = tableView.cellForRow(at: indexPath) as? FruitTableViewCell {
                    let fruit = fetchedResultsController.object(at: indexPath)
                    cell.setup(fruit: fruit)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }

            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            break;
        }
    }
}
