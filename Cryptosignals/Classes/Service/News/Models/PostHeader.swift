//
//  Feed.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

struct PostHeader {
    let title: String
    let imageUrl: String
    let html: String
}

// MARK: Codable
extension PostHeader: Codable {}

// MARK: Hashable
extension PostHeader: Hashable {}
