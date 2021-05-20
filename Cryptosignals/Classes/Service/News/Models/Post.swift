//
//  Post.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

struct Post {
    let id: Int
    let title: String
    let time: String
    let imageUrl: String
}

// MARK: Codable
extension Post: Codable {}

// MARK: Hashable
extension Post: Hashable {}
