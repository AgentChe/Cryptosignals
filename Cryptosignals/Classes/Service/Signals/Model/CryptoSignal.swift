//
//  Signal.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 21.05.2021.
//

struct CryptoSignal {
    enum Kind: Int, Codable {
        case long = 1
        case short = 2
    }
    
    let id: Int
    let exchangeId: Int
    let fromCurrencyId: Int
    let toCurrencyId: Int
    let timestamp: String
    let type: Kind
    let entry: Double
    let target: Double
    let gain: Double
}

// MARK: Codable
extension CryptoSignal: Codable {}

// MARK: Hashable
extension CryptoSignal: Hashable {}
