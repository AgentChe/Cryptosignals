//
//  PaygateMainView.swift
//  SleepWell
//
//  Created by Andrey Chernyshev on 12/06/2020.
//  Copyright © 2020 Andrey Chernyshev. All rights reserved.
//

import UIKit

final class PaygateMainView: UIView {
    lazy var closeButton = makeCloseButton()
    lazy var restoreButton = makeRestoreButton()
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var infoCell1 = makeInfoCell(title: "Paygate.Main.Cell1")
    lazy var infoCell2 = makeInfoCell(title: "Paygate.Main.Cell2")
    lazy var infoCell3 = makeInfoCell(title: "Paygate.Main.Cell3")
    lazy var leftOptionView = makeOptionView()
    lazy var rightOptionView = makeOptionView()
    lazy var lockImageView = makeLockIconView()
    lazy var securedLabel = makeSecuredLabel()
    lazy var continueButton = makeContinueButton()
    lazy var termsAndPolicyLabel = makeTermsAndPolicyLabel()
    lazy var purchasePreloaderView = makePreloaderView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        initialize()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(paygate: PaygateMainOffer) {
        let options = paygate.options?.prefix(2) ?? []
        
        if let leftOption = options.first {
            leftOptionView.isHidden = false
            leftOptionView.isSelected = false
            leftOptionView.setup(option: leftOption)
        } else {
            leftOptionView.isHidden = true
        }
        
        if options.count > 1, let rightOption = options.last {
            rightOptionView.isHidden = false
            rightOptionView.isSelected = true
            rightOptionView.setup(option: rightOption)
        } else {
            rightOptionView.isHidden = true
        }
    }
}

// MARK: Private
private extension PaygateMainView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 25, blue: 47)
    }
    
    @objc
    private func termsAndPolicyTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel, let text = label.text as NSString? else {
            return
        }
        
        let termsRange = text.range(of: "Paygate.Main.TermsOfUse".localized)
        let policyRange = text.range(of: "Paygate.Main.PrivacyPolicy".localized)
        
        var url: URL?

        if sender.didTapAttributedTextInLabel(label: label, inRange: termsRange) {
            url = URL(string: GlobalDefinitions.termsOfServiceUrl)
        } else if sender.didTapAttributedTextInLabel(label: label, inRange: policyRange) {
            url = URL(string: GlobalDefinitions.privacyPolicyUrl)
        }
        
        guard let openUrl = url else {
            return
        }
        
        UIApplication.shared.open(openUrl, options: [:])
    }
}

// MARK: Make constraints
private extension PaygateMainView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 427.scale),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 37.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 37.scale),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 54.scale : 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            restoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            restoreButton.heightAnchor.constraint(equalToConstant: 25.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 222.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell1.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoCell1.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoCell1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell2.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoCell2.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoCell2.topAnchor.constraint(equalTo: infoCell1.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell3.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoCell3.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoCell3.topAnchor.constraint(equalTo: infoCell2.bottomAnchor, constant: 10.scale)
        ])
    
        NSLayoutConstraint.activate([
            leftOptionView.widthAnchor.constraint(equalTo: rightOptionView.widthAnchor),
            leftOptionView.heightAnchor.constraint(equalToConstant: 185.scale),
            leftOptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            leftOptionView.trailingAnchor.constraint(equalTo: rightOptionView.leadingAnchor, constant: -13.scale),
            leftOptionView.topAnchor.constraint(equalTo: infoCell3.bottomAnchor, constant: 40.scale)
        ])
        
        NSLayoutConstraint.activate([
            rightOptionView.heightAnchor.constraint(equalToConstant: 185.scale),
            rightOptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            rightOptionView.topAnchor.constraint(equalTo: infoCell3.bottomAnchor, constant: 40.scale)
        ])
        
        NSLayoutConstraint.activate([
            lockImageView.widthAnchor.constraint(equalToConstant: 12.scale),
            lockImageView.heightAnchor.constraint(equalToConstant: 16.scale),
            lockImageView.trailingAnchor.constraint(equalTo: securedLabel.leadingAnchor, constant: -10.scale),
            lockImageView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -9.scale)
        ])
        
        NSLayoutConstraint.activate([
            securedLabel.centerYAnchor.constraint(equalTo: lockImageView.centerYAnchor),
            securedLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 60.scale),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -77.scale : -47.scale)
        ])
        
        NSLayoutConstraint.activate([
            termsAndPolicyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            termsAndPolicyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale),
            termsAndPolicyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -32.scale : -21.scale)
        ])
        
        NSLayoutConstraint.activate([
            purchasePreloaderView.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor),
            purchasePreloaderView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateMainView {
    func makeCloseButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Paygate.MainOffer.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRestoreButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Paygate.Main.RestorePurchases".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.Main.Image")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Paygate.Main.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeInfoCell(title: String) -> PaygateMainInfoCell {
        let view = PaygateMainInfoCell()
        view.backgroundColor = UIColor.clear
        view.title = title.localized
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeOptionView() -> PaygateOptionView {
        let view = PaygateOptionView()
        view.alpha = 0
        view.isHidden = true
        view.layer.cornerRadius = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLockIconView() -> UIImageView {
        let view = UIImageView()
        view.isHidden = !ScreenSize.isIphoneXFamily
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.Main.Lock")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSecuredLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 14.scale))
            .lineHeight(16.scale)
        
        let view = UILabel()
        view.attributedText = "Paygate.Main.Info".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 20.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Paygate.Continue".localized.attributed(with: attrs), for: .normal)
        view.isHidden = true
        view.backgroundColor = UIColor(integralRed: 63, green: 166, blue: 255)
        view.layer.cornerRadius = 15.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTermsAndPolicyLabel() -> UILabel {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.regular(size: 14.scale))
            .lineHeight(16.scale)
            .textColor(UIColor.white)
            .textAlignment(.center)
        
        let attrs2 = TextAttributes()
            .font(Fonts.SFProDisplay.regular(size: 12.scale))
            .lineHeight(14.scale)
            .textColor(UIColor.white.withAlphaComponent(0.5))
            .textAlignment(.center)
        
        let terms = "Paygate.Main.TermsOfUse".localized.attributed(with: attrs)
        let and = "Paygate.Main.And".localized.attributed(with: attrs2)
        let policy = "Paygate.Main.PrivacyPolicy".localized.attributed(with: attrs)
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(terms)
        attributedText.append(and)
        attributedText.append(policy)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndPolicyTapped(sender:)))
        
        let view = UILabel()
        view.attributedText = attributedText
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreloaderView() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
