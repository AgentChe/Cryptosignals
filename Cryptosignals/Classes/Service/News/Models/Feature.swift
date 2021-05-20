//
//  Feature.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

struct Feature {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
}

// MARK: Codable
extension Feature: Codable {}

// MARK: Hashable
extension Feature: Hashable {}
