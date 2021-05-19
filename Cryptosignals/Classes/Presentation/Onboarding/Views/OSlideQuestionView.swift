//
//  OSlideQuestionView.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 24.01.2021.
//

import UIKit

final class OSlideQuestionView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var questionLabel = makeQuestionLabel()
    lazy var yesButton = makeYesButton()
    lazy var noButton = makeNoButton()

    private let questionKey: String
    
    init(step: OnboardingView.Step, questionKey: String) {
        self.questionKey = questionKey
        
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension OSlideQuestionView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 174.scale : 100.scale)
        ])
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 98.scale)
        ])
        
        NSLayoutConstraint.activate([
            noButton.widthAnchor.constraint(equalToConstant: 163.scale),
            noButton.heightAnchor.constraint(equalToConstant: 108.scale),
            noButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            noButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
        
        NSLayoutConstraint.activate([
            yesButton.widthAnchor.constraint(equalToConstant: 163.scale),
            yesButton.heightAnchor.constraint(equalToConstant: 108.scale),
            yesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            yesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OSlideQuestionView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Question.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeQuestionLabel() -> OQuestionFormView {
        let view = OQuestionFormView()
        view.title = questionKey.localized
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeYesButton() -> OQuestionButton {
        let view = OQuestionButton()
        view.iconView.image = UIImage(named: "Onboarding.Yes")
        view.label.text = "Onboarding.Yes".localized
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeNoButton() -> OQuestionButton {
        let view = OQuestionButton()
        view.iconView.image = UIImage(named: "Onboarding.No")
        view.label.text = "Onboarding.No".localized
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
