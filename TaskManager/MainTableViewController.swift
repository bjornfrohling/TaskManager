//
//  MainTableViewController.swift
//  TaskManager
//
//  Created by Björn Fröhling on 01/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

  var managedObjectContext: NSManagedObjectContext!
  var dataSource: TableViewDataSource<TaskList, UITableViewCell>!
  var fetchedResultsProvider: FetchedResultsProvider<TaskList>!

  override func viewDidLoad() {
    super.viewDidLoad()

    populateList()
  }

  func populateList() {
    self.fetchedResultsProvider = FetchedResultsProvider(managedObjectContext)
    self.dataSource = TableViewDataSource(cellIdentifier: "Cell", tableView: self.tableView, provider: fetchedResultsProvider) { cell, model in
      cell.textLabel?.text = model.title
    }
    tableView.dataSource = self.dataSource
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = NewItemHeader(self, placeholder: "Create Task List") { title in

      let taskList = NSEntityDescription.insertNewObject(forEntityName: "TaskList", into: self.managedObjectContext) as! TaskList
      taskList.title = title
      do {
        try self.managedObjectContext.save()
      } catch {
        fatalError("insertNewObject failed :(")
      }
    }

    return headerView
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }

}

