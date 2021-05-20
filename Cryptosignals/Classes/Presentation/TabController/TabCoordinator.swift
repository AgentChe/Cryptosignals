//
//  TabCoordinator.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit

final class TabCoordinator {
    weak var parentVC: TabController?
    
    lazy var closedSignalsVC = NursingNavigationController(rootViewController: UIViewController())
    lazy var openedSignalsVC = NursingNavigationController(rootViewController: UIViewController())
    lazy var newsVC = NursingNavigationController(rootViewController: UIViewController())
    
    private var previousVC: UIViewController?
    
    init(parentVC: TabController) {
        self.parentVC = parentVC
    }
    
    func change(tab: TabBar.Tab) {
        parentVC?.mainView.tabView.selectedTab = tab
        
        switch tab {
        case .closedSignals:
            changeVC(on: closedSignalsVC)
        case .openedSignals:
            changeVC(on: openedSignalsVC)
        case .news:
            changeVC(on: newsVC)
        }
    }
}

// MARK: Private
private extension TabCoordinator {
    func changeVC(on vc: UIViewController) {
        if let previousVC = self.previousVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
    
        self.previousVC = vc
        
        guard let parentVC = self.parentVC else {
            return
        }
    
        parentVC.addChild(vc)
        vc.view.frame = parentVC.mainView.container.bounds
        parentVC.mainView.container.addSubview(vc.view)
        vc.willMove(toParent: parentVC)
    }
}
