//
//  User+CoreDataClass.swift
//  CoreDataJSON
//
//  Created by Master Family on 25/09/2020.
//
//

import Foundation
import CoreData

enum ProductError: Error {
    case contextMissing
    case entityCreationFailed
}

public class User: NSManagedObject, Decodable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case name, id, tags, friends, age, isActive, company, email, address, about, registered
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        // first we need to get the context again
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { throw ProductError.contextMissing }
        
        // then the entity we want to decode into, in this example it's the 'User' entity
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { throw ProductError.entityCreationFailed }
        
        // init self with the entity and context we just got
        self.init(entity: entity, insertInto: context)
        
        // as usual we need a container, I skipped creating the CodingKeys enum since that should be trivial
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // the rest is just doing the actual decoding, finally
        // I decided to remove the '?' from the properties in the classes of my entities since I know the data will be there
        self.id = try container.decode(UUID.self, forKey: .id)
        // if you wanted to leave them option and use wrappers, just use 'decodeIfPresent' instead of just 'decode'
        
        // the two not completely trivial properties are 'tags' and 'friends'
        // for tags I just decode the data first, then save it into the entities property
        let tagArray = try container.decode([String].self, forKey: .tags)
        self.tags = tagArray.joined(separator: ", ")
        
        // for friends I decode it as an array, then create an NSSet from that array
        // of course this requires that 'Friend' conforms to decodable too, but you should know how to do that now ;)
        let friendArray = try container.decode([Friend].self, forKey: .friends)
        self.friends = NSSet(array: friendArray)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        
    }
    
    
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSObject?
    @NSManaged public var relationshipFriends: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedAge: Int16 {
        age
    }
    
    public var wrappedCompany: String {
        company ?? ""
    }
    
    public var wrappedEmail: String {
        email ?? ""
    }
    
    public var wrappedAddress: String {
        address ?? ""
    }
    
    public var wrappedAbout: String {
        about ?? ""
    }
    
    public var wrappedRegistered: String {
        registered ?? ""
    }
    
    public var tagsArray: [String] {
        tags?.components(separatedBy: ", ") ?? []
    }
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted(by: {$0.wrappedName < $1.wrappedName})
    }
    
}

// MARK: Generated accessors for relationshipFriends
extension User {
    
    @objc(addRelationshipFriendsObject:)
    @NSManaged public func addToRelationshipFriends(_ value: Friend)
    
    @objc(removeRelationshipFriendsObject:)
    @NSManaged public func removeFromRelationshipFriends(_ value: Friend)
    
    @objc(addRelationshipFriends:)
    @NSManaged public func addToRelationshipFriends(_ values: NSSet)
    
    @objc(removeRelationshipFriends:)
    @NSManaged public func removeFromRelationshipFriends(_ values: NSSet)
    
}


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
