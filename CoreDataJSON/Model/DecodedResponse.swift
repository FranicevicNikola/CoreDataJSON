//
//  User+Codable.swift
//  CoreDataJSON
//
//  Created by Master Family on 17/09/2020.
//

import Foundation

struct UserJSON: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: Int16
    var isActive: Bool
    var company, email, address, about: String
    var registered: Date
    var tags: [String]
    var friends: [FriendJSON]
}


struct FriendJSON: Codable, Identifiable {
    var id: UUID
    var name: String
}
