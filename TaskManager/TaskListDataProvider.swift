//
//  TaskListDataProvider.swift
//  TaskManager
//
//  Created by Björn Fröhling on 04/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit
import CoreData

protocol TaskListDataProviderDelegate: class {
  func insertRows(at index: IndexPath)
  func removeRows(at index: IndexPath)
}

class TaskListDataProvider: NSObject, NSFetchedResultsControllerDelegate {

  var fetchResultsController: NSFetchedResultsController<TaskList>!
  var sections: [NSFetchedResultsSectionInfo]? { get { return self.fetchResultsController.sections } }
  var managedObjectContext: NSManagedObjectContext!
  weak var delegate: TaskListDataProviderDelegate!

  init(_ managedObjectContext: NSManagedObjectContext) {
    super.init()

    self.managedObjectContext = managedObjectContext
    let request = NSFetchRequest<TaskList>(entityName: "TaskList")
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchResultsController.delegate = self
    do {
      try fetchResultsController.performFetch()
    } catch {
      fatalError("Unable to performFetch")
    }
  }

  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    if type == .insert {
      if let idx = newIndexPath {
        delegate.insertRows(at: idx)
      }
    } else if type == .delete {
      if let idx = indexPath {
        delegate.removeRows(at: idx)
      }
    }
  }

  func object(at indexPath: IndexPath) -> TaskList {
    return self.fetchResultsController.object(at: indexPath)
  }

  func delete(_ taskList: TaskList) {
    managedObjectContext.delete(taskList)
    do {
      try managedObjectContext.save()
    } catch {
      fatalError("Error when deleting TaskList")
    }
  }

}
