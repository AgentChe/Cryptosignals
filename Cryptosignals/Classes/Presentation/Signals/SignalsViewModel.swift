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
        return self.signalsManager.obtainClosedSignals()
            .map { signals -> [CryptoSignalsTableElement] in
                signals.map { _ in CryptoSignalsTableElement() }
            }
            .asDriver(onErrorJustReturn: [])
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
                
                return self.signalsManager.obtainOpenedSignals()
                    .map { signals -> [CryptoSignalsTableElement] in
                        signals.map { _ in CryptoSignalsTableElement() }
                    }
                    .asDriver(onErrorJustReturn: [])
                    .map { Step.elements($0) }
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
}
