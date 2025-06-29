//
//  User.swift
//  UserList
//
//  Created by Vishwa Fernando on 2025-06-29.
//

import Foundation

struct UserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let email: String
    let phone: String
    let picture: Picture

    var fullName: String {
        return "\(name.title) \(name.first) \(name.last)"
    }

    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }

    struct Picture: Codable {
        let large: String
        let thumbnail: String
    }
}
