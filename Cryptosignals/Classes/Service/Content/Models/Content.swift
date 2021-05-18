//
//  Content.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

struct Content {
    /// Массив идентификаторов выбранных валют
    let currencies: [Int]
    
    /// Массив идентификаторов выбранных бирж
    let exchanges: [Int]
}

// MARK: Codable
extension Content: Codable {}

// MARK: Hashable
extension Content: Hashable {}
