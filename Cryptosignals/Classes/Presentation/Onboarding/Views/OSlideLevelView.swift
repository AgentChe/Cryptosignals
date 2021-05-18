//
//  OSlideLevelView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 17.05.2021.
//

import UIKit

final class OSlideLevelView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var cell1 = makeCell(title: "Onboarding.Level.Title1", subTitle: "Onboarding.Level.SubTitle1")
    lazy var cell2 = makeCell(title: "Onboarding.Level.Title2", subTitle: "Onboarding.Level.SubTitle2")
    lazy var cell3 = makeCell(title: "Onboarding.Level.Title3", subTitle: "Onboarding.Level.SubTitle3")
    lazy var cell4 = makeCell(title: "Onboarding.Level.Title4", subTitle: "Onboarding.Level.SubTitle4")
    lazy var button = makeButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        updateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OSlideLevelView {
    @objc
    func didSelect(tapGesture: UITapGestureRecognizer) {
        guard let tappedCell = tapGesture.view as? OLevelCell else {
            return
        }
        
        [
            cell1, cell2, cell3, cell4
        ]
        .forEach { $0.isSelected = false }
        
        tappedCell.isSelected = true
        
        updateButton()
    }
    
    func updateButton() {
        let isSelected = [
            cell1, cell2, cell3, cell4
        ].contains(where: { $0.isSelected })
        
        button.alpha = isSelected ? 1 : 0.5
    }
    
    @objc
    func didNext() {
        let views = [
            cell1, cell2, cell3, cell4
        ]
        
        guard views.contains(where: { $0.isSelected }) else {
            return
        }
        
        onNext()
    }
}

// MARK: Make constraints
private extension OSlideLevelView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 112.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            cell1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            cell1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            cell2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            cell2.topAnchor.constraint(equalTo: cell1.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            cell3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            cell3.topAnchor.constraint(equalTo: cell2.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            cell4.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            cell4.topAnchor.constraint(equalTo: cell3.bottomAnchor, constant: 12.scale)
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
private extension OSlideLevelView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Level.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(title: String, subTitle: String) -> OLevelCell {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelect(tapGesture:)))
        
        let view = OLevelCell()
        view.title = title.localized
        view.subTitle = subTitle.localized
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
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
        view.addTarget(self, action: #selector(didNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
