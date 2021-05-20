//
//  NewsViewController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit
import RxSwift

final class NewsViewController: UIViewController {
    lazy var mainView = NewsView()
    
    private lazy var viewModel = NewsViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements
            .drive(onNext: { [weak self] elements in
                self?.mainView.tableView.setup(elements: elements)
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.newsTableDelegate = self
    }
}

// MARK: Make
extension NewsViewController {
    static func make() -> NewsViewController {
        let vc = NewsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: NewsTableViewDelegate
extension NewsViewController: NewsTableViewDelegate {
    func newsTableDidTapped(id: Int) {
        print("id: \(id)")
    }
}
