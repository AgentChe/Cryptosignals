//
//  SignalsViewModel.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import RxSwift
import RxCocoa

final class SignalsViewModel {
    enum Step {
        case elements([CryptoSignalsTableElement])
        case needPayment
    }
    
    private let kind: SignalsViewController.Kind
    
    lazy var step = makeStep()
    
    private lazy var signalsManager = SignalsManagerCore()
    private lazy var sessionManager = SessionManagerCore()
    private lazy var contentManager = ContentManagerCore()
    
    init(kind: SignalsViewController.Kind) {
        self.kind = kind
    }
}

// MARK: Private
private extension SignalsViewModel {
    func makeStep() -> Driver<Step> {
        switch kind {
        case .closed:
            return closedSignals()
        case .opened:
            return openedSignals()
        }
    }
    
    func closedSignals() -> Driver<Step> {
        return getElemenets()
            .map { Step.elements($0) }
    }
    
    func openedSignals() -> Driver<Step> {
        makeActiveSubscription()
            .flatMapLatest { [weak self] activeSubscription -> Driver<Step> in
                guard let self = self else {
                    return .never()
                }
                
                guard activeSubscription else {
                    return .deferred { .just(.needPayment) }
                }
                
                return self.getElemenets()
                    .map { Step.elements($0) }
            }
    }
    
    func getElemenets() -> Driver<[CryptoSignalsTableElement]> {
        getSignals()
            .flatMapLatest(mapToElements)
    }
    
    func getSignals() -> Driver<[CryptoSignal]> {
        let trigger = Signal
            .merge(
                ContentMediator.shared
                    .rxDidUpdateSelectedExchangesIds
                    .map { _ in Void() },
                
                ContentMediator.shared
                    .rxDidUpdateSelectedCurrenciesIds
                    .map { _ in Void() }
            )
            .startWith(Void())
        
        return trigger
            .flatMapLatest { [weak self] _ -> Driver<[CryptoSignal]> in
                guard let self = self else {
                    return .never()
                }
                
                switch self.kind {
                case .closed:
                    return self.signalsManager
                        .obtainClosedSignals()
                        .asDriver(onErrorJustReturn: [])
                case .opened:
                    return self.signalsManager
                        .obtainOpenedSignals()
                        .asDriver(onErrorJustReturn: [])
                }
            }
    }
    
    func makeActiveSubscription() -> Driver<Bool> {
        let updated = SDKStorage.shared
            .purchaseMediator
            .rxPurchaseMediatorDidValidateReceipt
            .compactMap { $0?.activeSubscription }
            .asDriver(onErrorJustReturn: false)
        
        let initial = Driver<Bool>
            .deferred { [weak self] in
                guard let this = self else {
                    return .never()
                }
                
                let activeSubscription = this.sessionManager.getSession()?.activeSubscription ?? false
                
                return .just(activeSubscription)
            }
        
        return Driver
            .merge(initial, updated)
    }
    
    var mapToElements: ([CryptoSignal]) -> Driver<[CryptoSignalsTableElement]> {
        { [weak self] signals -> Driver<[CryptoSignalsTableElement]> in
            guard let self = self else {
                return .never()
            }
            
            return Driver
                .zip(
                    self.contentManager
                        .retrieveExchanges(forceUpdate: false)
                        .asDriver(onErrorJustReturn: []),
                    
                    self.contentManager
                        .retrieveCurrencies(forceUpdate: false)
                        .asDriver(onErrorJustReturn: [])
                ) { exchanges, currencies -> [CryptoSignalsTableElement] in
                    CryptoSignalsTableElementMapper.map(signals: signals,
                                                        exchanges: exchanges,
                                                        currencies: currencies)
                }
        }
    }
}
