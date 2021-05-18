//
//  ContentMediator.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import RxCocoa

final class ContentMediator {
    static let shared = ContentMediator()
    
    private var delegates = [Weak<ContentMediatorDelegate>]()
    
    private init() {}
    
    private lazy var updateSelectedCurrenciesIdsTrigger = PublishRelay<[Int]>()
    private lazy var updateSelectedExchangesIdsTrigger = PublishRelay<[Int]>()
}

// MARK: API
extension ContentMediator {
    func notifyAboutUpdate(selectedCurrenciesIds: [Int]) {
        DispatchQueue.main.async { [weak self] in
            ContentMediator.shared.delegates.forEach {
                $0.weak?.contentMediatorDidUpdate(selectedCurrenciesIds: selectedCurrenciesIds)
            }
            
            self?.updateSelectedCurrenciesIdsTrigger.accept(selectedCurrenciesIds)
        }
    }
    
    func notifyAboutUpdate(selectedExchangesIds: [Int]) {
        DispatchQueue.main.async { [weak self] in
            ContentMediator.shared.delegates.forEach {
                $0.weak?.contentMediatorDidUpdate(selectedExchangesIds: selectedExchangesIds)
            }
            
            self?.updateSelectedExchangesIdsTrigger.accept(selectedExchangesIds)
        }
    }
}

// MARK: Triggers(Rx)
extension ContentMediator {
    var rxDidUpdateSelectedCurrenciesIds: Signal<[Int]> {
        updateSelectedCurrenciesIdsTrigger.asSignal()
    }
    
    var rxDidUpdateSelectedExchangesIds: Signal<[Int]> {
        updateSelectedExchangesIdsTrigger.asSignal()
    }
}

// MARK: Observer
extension ContentMediator {
    public func add(delegate: ContentMediatorDelegate) {
        let weakly = delegate as AnyObject
        delegates.append(Weak<ContentMediatorDelegate>(weakly))
        delegates = delegates.filter { $0.weak != nil }
    }
    
    public func remove(delegate: ContentMediatorDelegate) {
        if let index = delegates.firstIndex(where: { $0.weak === delegate }) {
            delegates.remove(at: index)
        }
    }
}
