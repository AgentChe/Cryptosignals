//
//  STExchangesCollectionElement.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

final class STExchangesCollectionElement {
    let exchange: Exchange
    var isSelected: Bool
    
    init(exchange: Exchange,
         isSelected: Bool) {
        self.exchange = exchange
        self.isSelected = isSelected
    }
}
