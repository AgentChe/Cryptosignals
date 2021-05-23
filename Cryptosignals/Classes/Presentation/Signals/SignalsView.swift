//
//  SignalsView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import UIKit

final class SignalsView: UIView {
    lazy var titleLabel = makeTitleLabel()
    lazy var tableView = makeTableView()
    lazy var unlockPremiumView = makeUnlockPremiumView()
    
    private let type: SignalsViewController.Kind
    
    init(type: SignalsViewController.Kind) {
        self.type = type
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SignalsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 25, blue: 47)
    }
}

// MARK: Make constraints
private extension SignalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 80.scale : 45.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            unlockPremiumView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            unlockPremiumView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            unlockPremiumView.topAnchor.constraint(equalTo: tableView.topAnchor),
            unlockPremiumView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SignalsView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 34.scale))
            .lineHeight(41.scale)
            .letterSpacing(0.37.scale)
        
        let title: String
        switch type {
        case .closed:
            title = "Signals.ClosedTitle".localized
        case .opened:
            title = "Signals.OpenedTitle".localized
        }
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> CryptoSignalsTableView {
        let view = CryptoSignalsTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeUnlockPremiumView() -> UnlockPremiumView {
        let view = UnlockPremiumView()
        view.isHidden = true
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
