//
//  MockUserService.swift
//  UserListTests
//
//  Created by Vishwa Fernando on 2025-06-29.
//

import Foundation
@testable import UserList

class MockUserService: UserServiceProtocol {

    var shouldReturnError = false

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        } else {
            let user1 = User(name: User.Name(title: "Jane", first: "", last: "Smith"), email: "john@example.com", phone: "1234567890", picture: User.Picture(large: "", thumbnail: ""))
            let user2 = User(name: User.Name(title: "mike", first: "", last: "Smith"), email: "mike@example.com", phone: "01218201920", picture: User.Picture(large: "", thumbnail: ""))
            completion(.success([user1, user2]))
        }
    }
}
