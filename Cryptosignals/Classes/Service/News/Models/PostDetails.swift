//
//  PostDetails.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

struct PostDetails {
    let header: PostHeader?
    let posts: [Post]
}

// MARK: Codable
extension PostDetails: Codable {}

// MARK: Hashable
extension PostDetails: Hashable {}
