//
//  SplashViewModel.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import RxSwift
import RxCocoa

final class SplashViewModel {
    enum Step {
        case onboarding, main
    }
    
    private lazy var contentManager = ContentManagerCore()
    
    func step() -> Driver<Step> {
        library()
            .andThen(makeStep())
            .asDriver(onErrorDriveWith: .empty())
    }
}

// MARK: Private
private extension SplashViewModel {
    func library() -> Completable {
        Completable
            .zip(
                contentManager
                    .retrieveCurrencies(forceUpdate: true)
                    .catchAndReturn([])
                    .asCompletable(),
                
                contentManager
                    .retrieveExchanges(forceUpdate: true)
                    .catchAndReturn([])
                    .asCompletable()
            )
    }
    
    func makeStep() -> Observable<Step> {
        guard OnboardingViewController.wasViewed() else {
            return .deferred { .just(.onboarding) }
        }
        
        return .deferred { .just(.main) }
    }
}
