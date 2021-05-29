//
//  SettingsViewController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 27.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsViewController: UIViewController {
    lazy var mainView = SettingsView()
    
    private lazy var viewModel = SettingsViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.tokens
            .drive(onNext: { [weak self] tokens in
                self?.mainView.tokensTableView.setup(elements: tokens)
            })
            .disposed(by: disposeBag)
        
        viewModel.exchanges
            .drive(onNext: { [weak self] exchanges in
                self?.mainView.exchangesCollectionView.setup(elements: exchanges)
            })
            .disposed(by: disposeBag)
        
        mainView.searchTokensView
            .textField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.searchToken)
            .disposed(by: disposeBag)
        
        mainView.allExchangesButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = STAllExchangesViewController.make()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        addCloseItem()
    }
}

// MARK: Make
extension SettingsViewController {
    static func make() -> SettingsViewController {
        let vc = SettingsViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Settings.Title".localized
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}

// MARK: Private
private extension SettingsViewController {
    func addCloseItem() {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "Settings.Close")
        navigationItem.leftBarButtonItem = item
        
        item.rx.tap
            .asDriver(onErrorDriveWith: .never())
            .flatMapLatest { [weak self] _ -> Driver<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                let exchangesIds = self.mainView
                    .exchangesCollectionView
                    .elements
                    .filter { $0.isSelected }
                    .map { $0.exchange.id }
                
                let currenciesIds = self.mainView
                    .tokensTableView
                    .elements
                    .filter { $0.isSelected }
                    .map { $0.currency.id }
                
                return self.viewModel
                    .save(exchangesIds: exchangesIds,
                          currenciesIds: currenciesIds)
            }
            .drive(onNext: { [weak self] success in
                if success {
                    self?.dismiss(animated: true)
                } else {
                    Toast.notify(with: "Settings.FailedToSave".localized, style: .danger)
                }
            })
            .disposed(by: disposeBag)
    }
}
