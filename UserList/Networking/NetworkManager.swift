//
//  NetworkManager.swift
//  UserList
//
//  Created by Vishwa Fernando on 2025-06-29.
//

import Foundation

class NetworkManager: UserServiceProtocol {
    static let shared = NetworkManager()

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
         guard let url = URL(string: "https://randomuser.me/api/?results=20") else {
             completion(.failure(NSError(domain: "Invalid URL", code: -1)))
             return
         }

         URLSession.shared.dataTask(with: url) { data, response, error in

             if let error = error {
                 completion(.failure(error))
                 return
             }

             guard let data = data else {
                 completion(.failure(NSError(domain: "No data", code: -1)))
                 return
             }

             do {
                 let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
                 let users = decoded.results.map {
                     User(
                        name: User.Name(title: $0.name.title, first: $0.name.first, last: $0.name.last),
                         email: $0.email,
                         phone: $0.phone,
                         picture: $0.picture
                     )
                 }
                 completion(.success(users))
             } catch {
                 completion(.failure(error))
             }

         }.resume()
     }
}

