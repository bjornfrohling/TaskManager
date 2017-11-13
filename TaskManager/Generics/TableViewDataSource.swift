//
//  TableViewDataSource.swift
//  TaskManager
//
//  Created by Björn Fröhling on 12/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit
import CoreData

class TableViewDataSource<Model: NSManagedObject, Cell: UITableViewCell>: NSObject, UITableViewDataSource, FetchedResultsProviderDelegate where Model: ManagedObjectType {

  var cellIdentifier: String!
  var tableView :UITableView!
  var fetchedResultsProvider: FetchedResultsProvider<Model>!
  var populateCellClosure: (Cell, Model) -> ()
  
  init(cellIdentifier: String, tableView: UITableView, provider: FetchedResultsProvider<Model>, cellClosure: @escaping (Cell, Model) -> ()) {
    self.tableView = tableView
    self.cellIdentifier = cellIdentifier
    self.fetchedResultsProvider = provider
    self.populateCellClosure = cellClosure
    super.init()
    self.fetchedResultsProvider.delegate = self
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsProvider.numberOfRowsInSection(sectionNr: section)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsProvider.numberOfSections()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell

    let model = fetchedResultsProvider.dataObject(index: indexPath)

    self.populateCellClosure(cell, model)

    return cell
  }

  func insertRows(at index: IndexPath) {
    self.tableView.insertRows(at: [index], with: .automatic)
  }
  
  func removeRows(at index: IndexPath) {
    self.tableView.deleteRows(at: [index], with: .automatic)
  }
}
