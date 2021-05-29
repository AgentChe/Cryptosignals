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
        
        mainView.closeButton.rx.tap
            .asDriver(onErrorDriveWith: .never())
            .flatMapLatest { [weak self] _ -> Driver<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                let exchangesIds = [Int]()
                
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
        
        viewModel.tokens
            .drive(onNext: { [weak self] tokens in
                self?.mainView.tokensTableView.setup(elements: tokens)
            })
            .disposed(by: disposeBag)
        
        mainView.searchTokensView
            .textField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.searchToken)
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension SettingsViewController {
    static func make() -> SettingsViewController {
        let vc = SettingsViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}
