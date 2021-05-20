//
//  TabController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit
import RxSwift

final class TabController: UIViewController {
    lazy var mainView = TabView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var coordinator = TabCoordinator(parentVC: self)
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addActionsToTabs()
        
        rx.methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.update(selectedTab: .closedSignals)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension TabController {
    static func make() -> TabController {
        let vc = TabController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}
 
// MARK: Private
private extension TabController {
    func addActionsToTabs() {
        let closedSignalsGesture = UITapGestureRecognizer()
        mainView.tabView.closedSignalsItem.isUserInteractionEnabled = true
        mainView.tabView.closedSignalsItem.addGestureRecognizer(closedSignalsGesture)
        
        let openedSignalsGesture = UITapGestureRecognizer()
        mainView.tabView.openedSignalsItem.isUserInteractionEnabled = true
        mainView.tabView.openedSignalsItem.addGestureRecognizer(openedSignalsGesture)
        
        let newsGesture = UITapGestureRecognizer()
        mainView.tabView.newsItem.isUserInteractionEnabled = true
        mainView.tabView.newsItem.addGestureRecognizer(newsGesture)
        
        Observable
            .merge([
                closedSignalsGesture.rx.event.map { _ in TabBar.Tab.closedSignals },
                openedSignalsGesture.rx.event.map { _ in TabBar.Tab.openedSignals },
                newsGesture.rx.event.map { _ in TabBar.Tab.news }
            ])
            .subscribe(onNext: { [weak self] tab in
                self?.update(selectedTab: tab)
            })
            .disposed(by: disposeBag)
    }
    
    func update(selectedTab: TabBar.Tab) {
        coordinator.change(tab: selectedTab)
    }
}
