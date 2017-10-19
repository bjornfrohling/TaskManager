//
//  MainTableViewController.swift
//  TaskManager
//
//  Created by Björn Fröhling on 01/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, TaskListDataProviderDelegate {

  var managedObjectContext: NSManagedObjectContext!
  var taskListDataProvider: TaskListDataProvider!
  var dataSource: TableViewDataSource<TaskList, UITableViewCell>!
  var fetchedResultsProvider: FetchedResultsProvider<TaskList>!

  override func viewDidLoad() {
    super.viewDidLoad()

    populateList()
  }

  func populateList() {
    fetchedResultsProvider = FetchedResultsProvider(managedObjectContext)
    taskListDataProvider = TaskListDataProvider(self.managedObjectContext)
    taskListDataProvider.delegate = self
    dataSource = TableViewDataSource(cellIdentifier: "Cell", provider: fetchedResultsProvider) { cell, model in
      cell.textLabel?.text = model.title
    }
    tableView.dataSource = dataSource
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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

  func insertRows(at index: IndexPath) {
    self.tableView.insertRows(at: [index], with: .automatic)
  }

  func removeRows(at index: IndexPath) {
    self.tableView.deleteRows(at: [index], with: .automatic)
  }

}

