//
//  TaskList+CoreDataProperties.swift
//  
//
//  Created by Björn Fröhling on 13/11/2017.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TaskList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskList> {
        return NSFetchRequest<TaskList>(entityName: "TaskList")
    }

    @NSManaged public var title: String?

}
