//
//  OSlideExchangesView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class OSlideExchangesView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var exchangesView = makeExchangesCollectionView()
    lazy var button = makeButton()
    
    private lazy var manager = ContentManagerCore()
    
    private lazy var disposeBag = DisposeBag()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        exchangesCollectionViewDidChangeSelection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: CurrenciesCollectionViewDelegate
extension OSlideExchangesView: ExchangesCollectionViewDelegate {
    func exchangesCollectionViewDidChangeSelection() {
        changeEnabled()
    }
}

// MARK: Private
private extension OSlideExchangesView {
    func initialize() {
        Single
            .zip(
                manager.obtainContent(),
                manager.retrieveExchanges(forceUpdate: false)
            ) { content, exchanges -> [ExchangesCollectionElement] in
                let selectedIds = content?.exchanges ?? []
                
                let even = (exchanges.count % 2) == 0
                
                return exchanges
                    .sorted(by: { $0.sort < $1.sort })
                    .enumerated()
                    .map { index, exchange -> ExchangesCollectionElement in
                        ExchangesCollectionElement(exchange: exchange,
                                                   fullWidth: !even && index == (exchanges.count - 1),
                                                   isSelected: selectedIds.contains(exchange.id) || exchange.preselected)
                }
            }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] elements in
                self?.exchangesView.setup(elements: elements)
                self?.exchangesCollectionViewDidChangeSelection()
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }

                let selectedExchanges = self.exchangesView.elements
                    .filter { $0.isSelected }
                    .map { $0.exchange }

                return self.manager
                    .saveSelected(exchangesIds: selectedExchanges.map { $0.id })
            }
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] success in
                if success {
                    self?.onNext()
                } else {
                    Toast.notify(with: "Onboarding.Exchanges.ErrorToSave".localized, style: .danger)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func changeEnabled() {
        let isEmpty = exchangesView.elements
            .filter { $0.isSelected }
            .isEmpty

        button.isEnabled = !isEmpty
        button.alpha = isEmpty ? 0.5 : 1
    }
}

// MARK: Make constraints
private extension OSlideExchangesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 174.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            exchangesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            exchangesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            exchangesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale),
            exchangesView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24.scale)
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
private extension OSlideExchangesView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Exchanges.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeExchangesCollectionView() -> ExchangesCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16.scale
        layout.minimumInteritemSpacing = 13.scale
        
        let view = ExchangesCollectionView(frame: .zero, collectionViewLayout: layout)
        view.exchangesCollectionViewDelegate = self
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
