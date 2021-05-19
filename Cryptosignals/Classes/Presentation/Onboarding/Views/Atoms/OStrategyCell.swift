//
//  OStrategyCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 19.05.2021.
//

import UIKit

final class OStrategyCell: GradientView {
    lazy var titleLabel = makeLabel()
    
    var isSelected: Bool = false {
        didSet {
            update()
        }
    }
    
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor(integralRed: 201, green: 202, blue: 227))
                .font(Fonts.SFProDisplay.semiBold(size: 23.scale))
                .lineHeight(27.scale)
            titleLabel.attributedText = title.attributed(with: attrs)
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
private extension OStrategyCell {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        layer.cornerRadius = 15.scale
        
        isSelected = false
    }
    
    func update() {
        layer.borderWidth = isSelected ? 2.scale : 0
        layer.borderColor = isSelected ? UIColor(integralRed: 63, green: 166, blue: 255).cgColor : UIColor.clear.cgColor
        
        let colors1 = [
            UIColor(integralRed: 63, green: 166, blue: 255, alpha: 0.2).cgColor,
            UIColor(integralRed: 63, green: 166, blue: 255, alpha: 0.2).cgColor
        ]
        let colors2 = [
            UIColor(integralRed: 33, green: 34, blue: 65).cgColor,
            UIColor(integralRed: 44, green: 48, blue: 89).cgColor
        ]
        gradientLayer.colors = isSelected ? colors1 : colors2
    }
}

// MARK: Make constraints
private extension OStrategyCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OStrategyCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
