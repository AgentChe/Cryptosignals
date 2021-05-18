//
//  ContentManagerCore.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import RxSwift

final class ContentManagerCore: ContentManager {
    struct Constants {
        static let currenciesCacheKey = "content_manager_core_currencies_key"
    }
}

// MARK: Content
extension ContentManagerCore {
    func obtainContent() -> Single<Content?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetContentRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map(GetContentResponseMapper.map(from:))
    }
}

// MARK: Currencies
extension ContentManagerCore {
    func retrieveCurrencies(forceUpdate: Bool) -> Single<[Currency]> {
        guard forceUpdate else {
            return getCachedCurrencies()
        }
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: GetCurrenciesRequest())
            .map(GetCurrenciesResponseMapper.map(from:))
            .flatMap(cacheCurrencies)
    }
    
    func saveSelected(currenciesIds: [Int]) -> Single<Bool> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SaveSelectedCurrenciesRequest(userToken: userToken,
                                                    ids: currenciesIds)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map(ErrorChecker.withoutError(in:))
            .do(onSuccess: { _ in
                ContentMediator.shared.notifyAboutUpdate(selectedCurrenciesIds: currenciesIds)
            })
    }
}

// MARK: Private (Currencies)
private extension ContentManagerCore {
    var cacheCurrencies: ([Currency]) -> Single<[Currency]> {
        { currencies -> Single<[Currency]> in
            Single<[Currency]>
                .create { event in
                    guard let data = try? JSONEncoder().encode(currencies) else {
                        event(.success([]))
                        return Disposables.create()
                    }
                    
                    UserDefaults.standard.setValue(data, forKey: Constants.currenciesCacheKey)
                    
                    event(.success(currencies))
                    
                    return Disposables.create()
                }
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .observe(on: MainScheduler.asyncInstance)
        }
    }
    
    func getCachedCurrencies() -> Single<[Currency]> {
        Single<[Currency]>
            .create { event in
                guard let data = UserDefaults.standard.data(forKey: Constants.currenciesCacheKey) else {
                    event(.success([]))
                    return Disposables.create()
                }
                
                let array = try? JSONDecoder().decode([Currency].self, from: data)
                let currencies = array ?? []
                
                event(.success(currencies))
                
                return Disposables.create()
            }
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
    }
}
