//
//  STAllExchangesViewController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol STAllExchangesViewControllerDelegate: class {
    func allExchangesDidChangeSelection()
}

final class STAllExchangesViewController: UIViewController {
    weak var delegate: STAllExchangesViewControllerDelegate?
    
    lazy var mainView = STAllExchangesView()
    
    private lazy var viewModel = STAllExchangesViewModel(elements: elements)
    
    private lazy var disposeBag = DisposeBag()
    
    private let elements: [STExchangesCollectionElement]
    
    private init(elements: [STExchangesCollectionElement]) {
        self.elements = elements
        
        super.init(nibName: nil, bundle: nil)
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
        
        mainView.searchView
            .textField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)
        
        changeSelectionHandle()
    }
}

// MARK: Make
extension STAllExchangesViewController {
    static func make(elements: [STExchangesCollectionElement]) -> STAllExchangesViewController {
        let vc = STAllExchangesViewController(elements: elements)
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Settings.Exchange".localized
        return vc
    }
}

// MARK: Private
private extension STAllExchangesViewController {
    func changeSelectionHandle() {
        mainView.tableView.changeSelection = { [weak self] in
            self?.delegate?.allExchangesDidChangeSelection()
        }
    }
}
