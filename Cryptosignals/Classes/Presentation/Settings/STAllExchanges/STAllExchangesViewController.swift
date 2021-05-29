//
//  STAllExchangesViewController.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class STAllExchangesViewController: UIViewController {
    lazy var mainView = STAllExchangesView()
    
    private lazy var viewModel = STAllExchangesViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: Make
extension STAllExchangesViewController {
    static func make() -> STAllExchangesViewController {
        let vc = STAllExchangesViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "adsd"
        return vc
    }
}
