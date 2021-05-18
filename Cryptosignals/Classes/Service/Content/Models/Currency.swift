//
//  Currency.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

struct Currency {
    let id: Int
    let name: String
    let code: String
    let sort: Int
    let preselected: Bool
}

// MARK: Codable
extension Currency: Codable {}


// MARK: Hashable
extension Currency: Hashable {}
