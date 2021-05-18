//
//  ExchangesCollectionElement.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

final class ExchangesCollectionElement {
    let exchange: Exchange
    let fullWidth: Bool
    var isSelected: Bool
    
    init(exchange: Exchange,
         fullWidth: Bool,
         isSelected: Bool) {
        self.exchange = exchange
        self.fullWidth = fullWidth
        self.isSelected = isSelected
    }
}
