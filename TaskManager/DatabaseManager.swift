//
//  DatabaseManager.swift
//  TaskManager
//
//  Created by Björn Fröhling on 04/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit
import CoreData

class DatabaseManager: NSObject {

  var managedObjectContext: NSManagedObjectContext!
  
  func initializeCoreDataStack() {
    
    guard let modelUrl = Bundle.main.url(forResource: "TaskManagerDataModel", withExtension: "momd") else {
      fatalError("TaskManagerDataModel not found :(")
    }
    
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl) else {
      fatalError("Unable to initialize ManagedObjectModel")
    }
    
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    let fileManager = FileManager()
    
    guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      fatalError("Unable to get documents Url")
    }
    
    let storeUrl = documentsUrl.appendingPathComponent("TaskManager.sqlite")
    
    print(storeUrl)
    
    do {
      try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
    } catch {
      fatalError("Unable to addPersistentStore")
    }
    let type = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
    self.managedObjectContext = NSManagedObjectContext(concurrencyType: type)
    self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    
  }

  
}
