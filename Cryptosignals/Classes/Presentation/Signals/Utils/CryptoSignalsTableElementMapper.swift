//
//  CryptoSignalsTableElementMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 23.05.2021.
//

final class CryptoSignalsTableElementMapper {
    static func map(signals: [CryptoSignal],
                    exchanges: [Exchange],
                    currencies: [Currency]) -> [CryptoSignalsTableElement] {
        signals.map { _ in CryptoSignalsTableElement() }
    }
}
