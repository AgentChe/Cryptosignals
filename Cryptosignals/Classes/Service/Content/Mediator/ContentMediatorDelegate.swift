//
//  ContentMediatorDelegate.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

protocol ContentMediatorDelegate: class {
    func contentMediatorDidUpdate(selectedCurrenciesIds: [Int])
}
