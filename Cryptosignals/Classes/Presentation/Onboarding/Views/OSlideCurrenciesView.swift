//
//  OSlideCurrenciesView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class OSlideCurrenciesView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var currenciesView = makeCurrenciesCollectionView()
    lazy var button = makeButton()
    
    private lazy var manager = ContentManagerCore()
    
    private lazy var disposeBag = DisposeBag()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        currenciesCollectionViewDidChangeSelection()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: CurrenciesCollectionViewDelegate
extension OSlideCurrenciesView: CurrenciesCollectionViewDelegate {
    func currenciesCollectionViewDidChangeSelection() {
        changeEnabled()
    }
}

// MARK: Private
private extension OSlideCurrenciesView {
    func initialize() {
        Single
            .zip(
                manager.obtainContent(),
                manager.retrieveCurrencies(forceUpdate: false)
            ) { content, currencies -> [CurrenciesCollectionElement] in
                let selectedIds = content?.currencies ?? []
                
                return currencies
                    .sorted(by: { $0.sort < $1.sort })
                    .map { currency -> CurrenciesCollectionElement in
                    CurrenciesCollectionElement(currency: currency,
                                                isSelected: selectedIds.contains(currency.id) || currency.preselected)
                }
            }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] elements in
                self?.currenciesView.setup(elements: elements)
                self?.currenciesCollectionViewDidChangeSelection()
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }

                let selectedCurrencies = self.currenciesView.elements
                    .filter { $0.isSelected }
                    .map { $0.currency }

                return self.manager
                    .saveSelected(currenciesIds: selectedCurrencies.map { $0.id })
            }
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] success in
                if success {
                    self?.onNext()
                } else {
                    Toast.notify(with: "Onboarding.Currencies.ErrorToSave".localized, style: .danger)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func changeEnabled() {
        let isEmpty = currenciesView.elements
            .filter { $0.isSelected }
            .isEmpty
        
        button.isEnabled = !isEmpty
        button.alpha = isEmpty ? 0.5 : 1
    }
}

// MARK: Make constraints
private extension OSlideCurrenciesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 142.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            currenciesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            currenciesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            currenciesView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -107.scale),
            currenciesView.heightAnchor.constraint(equalToConstant: 352.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 61.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OSlideCurrenciesView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Currencies.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCurrenciesCollectionView() -> CurrenciesCollectionView {
        let view = CurrenciesCollectionView(frame: .zero, collectionViewLayout: CurrenciesCollectionLayout())
        view.currenciesCollectionViewDelegate = self
        view.contentInset = UIEdgeInsets(top: 0, left: 16.scale, bottom: 0, right: 16.scale)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 23.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 63, green: 166, blue: 255)
        view.layer.cornerRadius = 15.scale
        view.setAttributedTitle("Onboarding.Next".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

