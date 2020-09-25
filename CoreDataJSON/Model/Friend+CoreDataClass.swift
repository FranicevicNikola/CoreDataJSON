//
//  Friend+CoreDataClass.swift
//  CoreDataJSON
//
//  Created by Master Family on 25/09/2020.
//
//

import Foundation
import CoreData


public class Friend: NSManagedObject, Identifiable {

    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var relationshipFriendOf: User?

}
