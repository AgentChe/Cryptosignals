//
//  SettingsView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 27.05.2021.
//

import UIKit

final class SettingsView: UIView {
    lazy var closeButton = makeCloseButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var tokensTitleLabel = makeSectionTitleLabel()
    lazy var searchTokensView = makeSearchTokensView()
    lazy var tokensTableView = makeTokensTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SettingsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 25, blue: 47)
        
        let sectionTitleAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.scale)
            .letterSpacing(0.37.scale)
            .textColor(UIColor.white)
        tokensTitleLabel.attributedText = "Settings.Tokens".localized.attributed(with: sectionTitleAttrs)
    }
}

// MARK: Make constraints
private extension SettingsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            closeButton.widthAnchor.constraint(equalToConstant: 32.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 32.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 59.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            tokensTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            tokensTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 215.scale : 215.scale)
        ])
        
        NSLayoutConstraint.activate([
            searchTokensView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            searchTokensView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            searchTokensView.heightAnchor.constraint(equalToConstant: 36.scale),
            searchTokensView.topAnchor.constraint(equalTo: tokensTitleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            tokensTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tokensTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tokensTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tokensTableView.topAnchor.constraint(equalTo: searchTokensView.bottomAnchor, constant: 4.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SettingsView {
    func makeCloseButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Settings.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 23.scale))
            .lineHeight(40.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Settings.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSectionTitleLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSearchTokensView() -> SettinsSearchView {
        let view = SettinsSearchView()
        view.placeholder = "Settings.SearchPlaceholder".localized
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTokensTableView() -> TokensTableView {
        let view = TokensTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
