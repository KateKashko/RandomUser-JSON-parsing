//
//  User.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import Foundation
struct UserResult: Decodable {
    let results: [User]
}

struct User: Decodable {
    let name: Name
    let email: String
    let phone: String
    let location: Location
    let picture: Picture
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Location: Decodable {
    let city: String
    let country: String
}

struct Picture: Decodable {
    let large: URL
    let thumbnail: URL
}
