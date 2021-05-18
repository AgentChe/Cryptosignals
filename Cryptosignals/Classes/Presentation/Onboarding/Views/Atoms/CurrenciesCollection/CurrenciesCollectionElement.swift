//
//  TopicsCollectionElement.swift
//  CDL
//
//  Created by Andrey Chernyshev on 22.04.2021.
//

import UIKit

final class CurrenciesCollectionElement {
    let currency: Currency
    var isSelected: Bool
    
    init(currency: Currency, isSelected: Bool) {
        self.currency = currency
        self.isSelected = isSelected
    }
}

// MARK: API
extension CurrenciesCollectionElement {
    func width(for height: CGFloat) -> CGFloat {
        return CurrenciesCollectionCell.size(for: self, with: height).width
    }
}
