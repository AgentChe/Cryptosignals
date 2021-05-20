//
//  NewsManagerCore.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import RxSwift

final class NewsManagerCore: NewsManager {}

// MARK: NewsManager
extension NewsManagerCore {
    func obtainNews() -> Single<News?> {
        SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: GetNewsRequest())
            .map(GetNewsResponseMapper.map(from:))
    }
    
    func obtaintDetails(with id: Int) -> Single<PostDetails?> {
        let request = GetPostDetailsRequest(id: id)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map(GetPostDetailsResponseMapper.map(from:))
    }
}
