//
//  CryptoSignalsTableElement.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

struct CryptoSignalsTableElement {
    let currencies: String
    let type: CryptoSignal.Kind
    let date: Date
    let dateString: String
    let exchange: String
    let gain: String
    let entryPoint: String
    let targetPrice: String
}
