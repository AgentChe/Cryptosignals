//
//  NewsManager.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import RxSwift

protocol NewsManager {
    func obtainNews() -> Single<News?>
}
