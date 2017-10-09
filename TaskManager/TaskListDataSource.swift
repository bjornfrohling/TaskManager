//
//  TaskListDataSource.swift
//  TaskManager
//
//  Created by Björn Fröhling on 04/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit

class TaskListDataSource: NSObject, UITableViewDataSource {

  var taskListDataProvider: TaskListDataProvider!

  init(_ dataProvider: TaskListDataProvider) {
    super.init()
    taskListDataProvider = dataProvider
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    guard let sections = self.taskListDataProvider.sections else {
      return 0
    }
    return sections[section].numberOfObjects
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let taskList = self.taskListDataProvider.object(at: indexPath)
    cell.textLabel?.text = taskList.title
    return cell
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let taskList = self.taskListDataProvider.object(at: indexPath)
      taskListDataProvider.delete(taskList)

    }
  }

}
