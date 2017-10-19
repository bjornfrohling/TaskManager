//
//  TableViewDataSource.swift
//  TaskManager
//
//  Created by Björn Fröhling on 12/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit
import CoreData

class TableViewDataSource<Model: NSManagedObject, Cell: UITableViewCell>: NSObject, UITableViewDataSource where Model: ManagedObjectType {

  var cellIdentifier: String!
  var fetchedResultsProvider: FetchedResultsProvider<Model>!
  var populateCellClosure: (Cell, Model) -> ()

  init(cellIdentifier: String, provider: FetchedResultsProvider<Model>, cellClosure: @escaping (Cell, Model) -> ()) {
    self.cellIdentifier = cellIdentifier
    self.fetchedResultsProvider = provider
    self.populateCellClosure = cellClosure
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

}
