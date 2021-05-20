//
//  NewsViewModel.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import RxCocoa

final class NewsViewModel {
    private lazy var newsManager = NewsManagerCore()
    
    lazy var elements = makeElements()
}

// MARK: Private
private extension NewsViewModel {
    func makeElements() -> Driver<[NewsTableElement]> {
        newsManager
            .obtainNews()
            .map { news -> [NewsTableElement] in
                var elements = [NewsTableElement]()
                
                if let features = news?.features {
                    let array = features.map { NewsTableElement.feature($0) }
                    elements.append(contentsOf: array)
                }
                
                if let posts = news?.posts {
                    let array = posts.map { NewsTableElement.post($0) }
                    
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
