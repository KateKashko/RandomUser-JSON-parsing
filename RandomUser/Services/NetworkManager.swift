//
//  NetworkManager.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    var users: [User] = []
    static let shared = NetworkManager()
     let url = URL(string: "https://randomuser.me/api/?format=json&results=20")!
    
    private init() {}

    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchUser(from url: URL, completion: @escaping(Result<UserResult, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let newUser = try decoder.decode(UserResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(newUser))
                }
            } catch  {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
