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
        addFilterActions()
        addSettingsAction()
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
    
    func addFilterActions() {
        let todayTapGesture = UITapGestureRecognizer()
        mainView.filterView.todayLabel.isUserInteractionEnabled = true
        mainView.filterView.todayLabel.addGestureRecognizer(todayTapGesture)
        
        let yesterdayTapGesture = UITapGestureRecognizer()
        mainView.filterView.yesterdayLabel.isUserInteractionEnabled = true
        mainView.filterView.yesterdayLabel.addGestureRecognizer(yesterdayTapGesture)
        
        let lastWeekTapGesture = UITapGestureRecognizer()
        mainView.filterView.lastWeekLabel.isUserInteractionEnabled = true
        mainView.filterView.lastWeekLabel.addGestureRecognizer(lastWeekTapGesture)
        
        let olderTapGesture = UITapGestureRecognizer()
        mainView.filterView.olderLabel.isUserInteractionEnabled = true
        mainView.filterView.olderLabel.addGestureRecognizer(olderTapGesture)
        
        Observable
            .merge(
                todayTapGesture.rx.event.map { event in SignalFilterView.Filter.today },
                yesterdayTapGesture.rx.event.map { event in SignalFilterView.Filter.yesterday },
                lastWeekTapGesture.rx.event.map { event in SignalFilterView.Filter.lastWeek },
                olderTapGesture.rx.event.map { event in SignalFilterView.Filter.older }
            )
            .startWith(.today)
            .subscribe(onNext: { [weak self] filter in
                self?.viewModel.filter.accept(filter)
                self?.mainView.filterView.filter = filter
            })
            .disposed(by: disposeBag)
    }
    
    func addSettingsAction() {
        let tapGesture = UITapGestureRecognizer()
        mainView.settingsButton.isUserInteractionEnabled = true
        mainView.settingsButton.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { event in
                print("open settings")
            })
            .disposed(by: disposeBag)
    }
}
