//
//  TokensTableElement.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

final class TokensTableElement {
    let currency: Currency
    var isSelected: Bool
    
    init(currency: Currency,
         isSelected: Bool) {
        self.currency = currency
        self.isSelected = isSelected
    }
}
