//
//  FetchedResultsProvider.swift
//  TaskManager
//
//  Created by Björn Fröhling on 11/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import Foundation
import CoreData

protocol FetchedResultsProviderDelegate: class {
  func insertRows(at index: IndexPath)
  func removeRows(at index: IndexPath)
}


class FetchedResultsProvider <T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate where T: ManagedObjectType {

  var managedObjectContext: NSManagedObjectContext!
  var fetchedResultsController: NSFetchedResultsController<T>!
  weak var delegate: FetchedResultsProviderDelegate!
  
  init(_ managedObjectContext: NSManagedObjectContext) {
    super.init()

    self.managedObjectContext = managedObjectContext

    let request = NSFetchRequest<T>(entityName: T.entityName)
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

    self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    self.fetchedResultsController.delegate = self

    do {
      try self.fetchedResultsController.performFetch()
    } catch {
      fatalError("self.fetchedResultsController.performFetch() Error")
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
  
  func numberOfSections() -> Int {
    guard let sections = fetchedResultsController.sections else {
      return 0
    }
    return sections.count
  }
  
  func numberOfRowsInSection(sectionNr: Int) -> Int {
    guard let sections = fetchedResultsController.sections else {
      return 0
    }
    return sections[sectionNr].numberOfObjects
  }
  
  func dataObject(index: IndexPath) -> T {
    return fetchedResultsController.object(at: index)
  }

}
