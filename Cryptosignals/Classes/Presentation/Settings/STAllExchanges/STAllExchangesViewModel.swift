//
//  STAllExchangesViewModel.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import RxSwift
import RxCocoa

final class STAllExchangesViewModel {
    lazy var search = BehaviorRelay<String>(value: "")
    
    lazy var elements = makeElements()
    
    private lazy var input = BehaviorRelay<[STExchangesCollectionElement]>(value: [])
    
    init(elements: [STExchangesCollectionElement]) {
        self.input.accept(elements)
    }
}

// MARK: Private
private extension STAllExchangesViewModel {
    func makeElements() -> Driver<[STExchangesCollectionElement]> {
        let _elements = input.asDriver()
        let _search = search.asDriver()
        
        return Driver
            .combineLatest(
                _elements, _search
            ) { elements, search -> [STExchangesCollectionElement] in
                guard !search.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return elements
                }
                
                return elements.filter {
                    $0.exchange.name.lowercased().contains(search.lowercased())
                }
            }
    }
}
