//
//  User+CoreDataClass.swift
//  CoreDataJSON
//
//  Created by Master Family on 17/09/2020.
//
//

import Foundation
import CoreData


public class User: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    enum CodingKeys: CodingKey {
        case name, age, isActive, company, email, address, about, registered, tags, friends
    }
    
//    required public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        age = try container.decode(Int16.self, forKey: .age)
//        isActive = try container.decode(Bool.self, forKey: .isActive)
//        company = try container.decode(String.self, forKey: .company)
//        email = try container.decode(String.self, forKey: .email)
//        address = try container.decode(String.self, forKey: .address)
//        about = try container.decode(String.self, forKey: .about)
//        registered = try container.decode(String.self, forKey: .registered)
//        tags = try container.decode(String.self, forKey: .tags)
//        friends = try container.decode(NSSet.self, forKey: .friends)
//    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
}
