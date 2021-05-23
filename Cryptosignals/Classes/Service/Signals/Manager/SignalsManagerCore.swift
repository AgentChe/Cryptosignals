//
//  SignalsManagerCore.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import RxSwift

final class SignalsManagerCore: SignalsManager {}

// MARK: Obtain
extension SignalsManagerCore {
    func obtainClosedSignals() -> Single<[CryptoSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetClosedSignalsRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map(GetClosedSignalsResponseMapper.map(from:))
    }
    
    func obtainOpenedSignals() -> Single<[CryptoSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetOpenedSignalsRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map(GetClosedSignalsResponseMapper.map(from:))
    }
}
