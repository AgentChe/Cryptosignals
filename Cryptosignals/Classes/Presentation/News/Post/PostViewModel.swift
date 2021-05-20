//
//  PostViewModel.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import RxCocoa

final class PostViewModel {
    lazy var postId = BehaviorRelay<Int?>(value: nil)
    
    private lazy var newsManager = NewsManagerCore()
    
    lazy var elements = postId
        .flatMapLatest { [weak self] id -> Driver<[PostTableElement]> in
            guard let self = self, let id = id else {
                return .never()
            }
            
            return self.makeElements(id: id)
        }
        .asDriver(onErrorJustReturn: [])
}

// MARK: Private
private extension PostViewModel {
    func makeElements(id: Int) -> Driver<[PostTableElement]> {
        newsManager
            .obtaintDetails(with: id)
            .map { details -> [PostTableElement] in
                var elements = [PostTableElement]()
                
                if let header = details?.header {
                    elements.append(.header(header))
                }
                
                if let posts = details?.posts {
                    let array = posts.map { PostTableElement.post($0) }
                    
                    if !array.isEmpty {
                        elements.append(.title("News.MoreForYou".localized))
                    }
                    
                    elements.append(contentsOf: array)
                }
                
                return elements
            }
            .asDriver(onErrorJustReturn: [])
    }
}
