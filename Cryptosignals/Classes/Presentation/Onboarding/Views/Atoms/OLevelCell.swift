//
//  OLevelCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 17.05.2021.
//

import UIKit

final class OLevelCell: GradientView {
    lazy var titleLabel = makeLabel()
    lazy var subTitleLabel = makeLabel()
    lazy var imageView = makeImageView()
    
    var isSelected: Bool = false {
        didSet {
            imageView.image = UIImage(named: isSelected ? "Onboarding.Level.Checked" : "Onboarding.Level.Unchecked")
        }
    }
    
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor.white)
                .font(Fonts.SFProDisplay.semiBold(size: 23.scale))
                .lineHeight(27.scale)
            titleLabel.attributedText = title.attributed(with: attrs)
        }
    }
    
    var subTitle: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor.white.withAlphaComponent(0.5))
                .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
                .lineHeight(23.scale)
            subTitleLabel.attributedText = subTitle.attributed(with: attrs)
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
private extension OLevelCell {
    func initialize() {
        gradientLayer.colors = [
            UIColor(integralRed: 33, green: 34, blue: 65).cgColor,
            UIColor(integralRed: 44, green: 48, blue: 89).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        layer.cornerRadius = 15.scale
        layer.masksToBounds = true
        
        isSelected = false
    }
}

// MARK: Make constraints
private extension OLevelCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 8.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -59.scale),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -16.scale : -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24.scale),
            imageView.widthAnchor.constraint(equalToConstant: 24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OLevelCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
