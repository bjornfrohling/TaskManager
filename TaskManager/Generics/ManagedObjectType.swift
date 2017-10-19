//
//  ManagedObjectType.swift
//  TaskManager
//
//  Created by Björn Fröhling on 11/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import Foundation

protocol ManagedObjectType: class {
  static var entityName: String {get}
}
