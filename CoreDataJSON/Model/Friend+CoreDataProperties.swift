//
//  Friend+CoreDataProperties.swift
//  CoreDataJSON
//
//  Created by Master Family on 17/09/2020.
//
//

import Foundation
import CoreData


extension Friend {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var friends: NSSet?
    
    
    
}
