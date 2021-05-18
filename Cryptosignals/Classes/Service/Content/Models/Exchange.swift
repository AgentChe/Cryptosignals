//
//  Exchange.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

struct Exchange {
    let id: Int
    let name: String
    let sort: Int
    let preselected: Bool
}

// MARK: Codable
extension Exchange: Codable {}


// MARK: Hashable
extension Exchange: Hashable {}
