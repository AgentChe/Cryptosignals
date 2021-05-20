//
//  PostViewController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit
import RxSwift

final class PostViewController: UIViewController {
    lazy var mainView = PostView()
    
    private lazy var viewModel = PostViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private let id: Int
    
    private init(id: Int) {
        self.id = id
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.postId.accept(id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        mainView.closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.postTableDelegate = self
    }
}

// MARK: Make
extension PostViewController {
    static func make(postId: Int) -> PostViewController {
        let vc = PostViewController(id: postId)
        vc.modalPresentationStyle = .overFullScreen
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: PostTableViewDelegate
extension PostViewController: PostTableViewDelegate {
    func postTableDidTapped(id: Int) {
        let vc = PostViewController.make(postId: id)
        present(vc, animated: true)
    }
}
