//
//  OSlideInterestView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import UIKit

final class OSlideInterestView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var tag1 = makeTag(title: "Onboarding.Interest.Tag1", tag: 1)
    lazy var tag2 = makeTag(title: "Onboarding.Interest.Tag2", tag: 2)
    lazy var tag3 = makeTag(title: "Onboarding.Interest.Tag3", tag: 3)
    lazy var tag4 = makeTag(title: "Onboarding.Interest.Tag4", tag: 4)
    lazy var tag5 = makeTag(title: "Onboarding.Interest.Tag5", tag: 5)
    lazy var tag6 = makeTag(title: "Onboarding.Interest.Tag6", tag: 6)
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
private extension OSlideInterestView {
    @objc
    func selected(tapGesture: UITapGestureRecognizer) {
        guard let tagView = tapGesture.view as? OInterestCell else {
            return
        }
        
        tagView.isSelected.toggle()
        
        updateButton()
    }
    
    func updateButton() {
        let isSelected = [
            tag1, tag2, tag3, tag4, tag5, tag6
        ].contains(where: { $0.isSelected })
        
        button.alpha = isSelected ? 1 : 0.5
    }
    
    @objc
    func didNext() {
        let views = [
            tag1, tag2, tag3, tag4, tag5, tag6
        ]
        
        guard views.contains(where: { $0.isSelected }) else {
            return
        }
        
        onNext()
    }
}

// MARK: Make constraints
private extension OSlideInterestView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 174.scale : 80.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21.scale),
            tag1.widthAnchor.constraint(equalToConstant: 154.scale),
            tag1.heightAnchor.constraint(equalToConstant: 154.scale),
            tag1.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 253.scale : 170.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 182.scale),
            tag2.widthAnchor.constraint(equalToConstant: 112.scale),
            tag2.heightAnchor.constraint(equalToConstant: 112.scale),
            tag2.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 267.scale : 197.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22.scale),
            tag3.widthAnchor.constraint(equalToConstant: 122.scale),
            tag3.heightAnchor.constraint(equalToConstant: 122.scale),
            tag3.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 418.scale : 348.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 140.scale),
            tag4.widthAnchor.constraint(equalToConstant: 94.scale),
            tag4.heightAnchor.constraint(equalToConstant: 94.scale),
            tag4.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 382.scale : 312.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag5.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 131.scale),
            tag5.widthAnchor.constraint(equalToConstant: 120.scale),
            tag5.heightAnchor.constraint(equalToConstant: 120.scale),
            tag5.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 494.scale : 424.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag6.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 234.scale),
            tag6.widthAnchor.constraint(equalToConstant: 120.scale),
            tag6.heightAnchor.constraint(equalToConstant: 120.scale),
            tag6.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 410.scale : 340.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            button.heightAnchor.constraint(equalToConstant: 60.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -70.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OSlideInterestView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Interest.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTag(title: String, tag: Int) -> OInterestCell {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selected(tapGesture:)))
        
        let view = OInterestCell()
        view.tag = tag
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.isSelected = false
        view.text = title.localized
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
