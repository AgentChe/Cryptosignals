//
//  SignalsViewController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import UIKit
import RxSwift

final class SignalsViewController: UIViewController {
    enum Kind {
        case closed, opened
    }
    
    lazy var mainView = SignalsView(type: kind)
    
    private let kind: Kind
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SignalsViewModel(kind: kind)
    
    private init(kind: Kind) {
        self.kind = kind
        
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
        
        viewModel.step
            .drive(onNext: step)
            .disposed(by: disposeBag)
        
        addUnlockPremiumAction()
    }
}

// MARK: Make
extension SignalsViewController {
    static func make(kind: Kind) -> SignalsViewController {
        let vc = SignalsViewController(kind: kind)
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension SignalsViewController {
    var step: (SignalsViewModel.Step) -> Void {
        { [weak self] step in
            switch step {
            case .elements(let elements):
                self?.mainView.tableView.setup(elements: elements)
                self?.mainView.unlockPremiumView.isHidden = true
            case .needPayment:
                self?.mainView.unlockPremiumView.isHidden = false
            }
        }
    }
    
    func addUnlockPremiumAction() {
        let tapGesture = UITapGestureRecognizer()
        mainView.unlockPremiumView.container.isUserInteractionEnabled = true
        mainView.unlockPremiumView.container.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { _ in
                UIApplication.shared.keyWindow?.rootViewController?.present(PaygateViewController.make(), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
