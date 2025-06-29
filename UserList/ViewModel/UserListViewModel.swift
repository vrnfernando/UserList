//
//  UserListViewModel.swift
//  UserList
//
//  Created by Vishwa Fernando on 2025-06-29.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserListViewModel {
    private let service: UserServiceProtocol

    private(set) var users: [User] = []
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(service: UserServiceProtocol = NetworkManager()) {
         self.service = service
     }

    func fetchUsers() {
        NetworkManager.shared.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.onUpdate?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }

    func user(at index: Int) -> User {
        return users[index]
    }

    var userCount: Int {
        return users.count
    }
}
