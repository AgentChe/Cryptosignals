//
//  SettingsView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 27.05.2021.
//

import UIKit

final class SettingsView: UIView {
    lazy var exchangesTitleLabel = makeSectionTitleLabel()
    lazy var allExchangesButton = makeAllExchangesButton()
    lazy var exchangesCollectionView = makeExchangesCollectionView()
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
        exchangesTitleLabel.attributedText = "Settings.Exchange".localized.attributed(with: sectionTitleAttrs)
    }
}

// MARK: Make constraints
private extension SettingsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            exchangesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            exchangesTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 119.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            allExchangesButton.heightAnchor.constraint(equalToConstant: 20.scale),
            allExchangesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            allExchangesButton.centerYAnchor.constraint(equalTo: exchangesTitleLabel.centerYAnchor),
            allExchangesButton.widthAnchor.constraint(equalToConstant: 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            exchangesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            exchangesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            exchangesCollectionView.heightAnchor.constraint(equalToConstant: 36.scale),
            exchangesCollectionView.topAnchor.constraint(equalTo: exchangesTitleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            tokensTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            tokensTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 215.scale : 186.scale)
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
    func makeSectionTitleLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAllExchangesButton() -> UIButton {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .textColor(UIColor(integralRed: 63, green: 166, blue: 255))
            .letterSpacing(0.37.scale)
            .textAlignment(.right)
        
        let view = UIButton()
        view.setAttributedTitle("Settings.All".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeExchangesCollectionView() -> STExchangesCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = STExchangesCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
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
