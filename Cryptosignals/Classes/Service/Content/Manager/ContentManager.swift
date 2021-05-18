//
//  ContentManager.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import RxSwift

protocol ContentManager: class {
    // MARK: Currency
    func retrieveCurrencies(forceUpdate: Bool) -> Single<[Currency]>
    func saveSelected(currenciesIds: [Int]) -> Single<Bool>
    
    // MARK: Content
    func obtainContent() -> Single<Content?>
}
