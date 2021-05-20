//
//  News.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

struct News {
    let features: [Feature]
    let posts: [Post]
}

// MARK: Codable
extension News: Codable {}

// MARK: Hashable
extension News: Hashable {}
