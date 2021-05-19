//
//  OQuestionFormView.swift
//  CDL
//
//  Created by Andrey Chernyshev on 16.04.2021.
//

import UIKit

final class OQuestionFormView: UIView {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .font(Fonts.SFProDisplay.semiBold(size: 20.scale))
                .lineHeight(28.scale)
                .textColor(UIColor.white)
            label.attributedText = title.attributed(with: attrs)
        }
    }
    
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
private extension OQuestionFormView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension OQuestionFormView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24.scale),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -24.scale),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OQuestionFormView {
    func makeContainer() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.gradientLayer.colors = [
            UIColor(integralRed: 33, green: 34, blue: 65).cgColor,
            UIColor(integralRed: 44, green: 48, blue: 89).cgColor
        ]
        view.layer.cornerRadius = 15.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
