//
//  SignalsManager.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import RxSwift

protocol SignalsManager {
    func obtainClosedSignals() -> Single<[CryptoSignal]>
    func obtainOpenedSignals() -> Single<[CryptoSignal]>
}
