//
//  SettingsViewModel.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 27.05.2021.
//

import RxSwift
import RxCocoa

final class SettingsViewModel {
    lazy var searchToken = BehaviorRelay<String>(value: "")
    
    lazy var tokens = makeTokens()
    
    private lazy var contentManager = ContentManagerCore()
    
    private lazy var content = makeContent()
    
    func save(exchangesIds: [Int], currenciesIds: [Int]) -> Driver<Bool> {
        Driver
            .zip(
                contentManager
                    .saveSelected(currenciesIds: currenciesIds)
                    .asDriver(onErrorJustReturn: false),
                
                contentManager
                    .saveSelected(exchangesIds: exchangesIds)
                    .asDriver(onErrorJustReturn: false)
            )
            .map { $0 && $1 }
    }
}

// MARK: Private
private extension SettingsViewModel {
    func makeTokens() -> Driver<[TokensTableElement]> {
        let elements = Driver
            .zip(
                content,
                
                contentManager
                    .retrieveCurrencies(forceUpdate: false)
                    .asDriver(onErrorJustReturn: [])
            ) { content, currencies -> [TokensTableElement] in
                let selectedCurrenciesIds = content?.currencies ?? []
                
                return currencies
                    .map { currency -> TokensTableElement in
                        TokensTableElement(currency: currency,
                                           isSelected: selectedCurrenciesIds.contains(currency.id)) }
            }
        
        let search = searchToken.asDriver()
        
        return Driver
            .combineLatest(
                elements, search
            ) { elements, search -> [TokensTableElement] in
                guard !search.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return elements
                }
                
                return elements.filter {
                    $0.currency.code.lowercased().contains(search.lowercased())
                }
            }
    }
    
    func makeContent() -> Driver<Content?> {
        contentManager
            .obtainContent()
            .asDriver(onErrorJustReturn: nil)
    }
}
