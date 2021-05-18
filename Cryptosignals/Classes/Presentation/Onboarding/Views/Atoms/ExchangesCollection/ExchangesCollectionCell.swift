//
//  ExchangesCollectionCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import UIKit

final class ExchangesCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: API
extension ExchangesCollectionCell {
    func setup(element: ExchangesCollectionElement) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .textAlignment(.center)
        label.attributedText = element.exchange.name.attributed(with: attrs)
        
        let colors1 = [
            UIColor(integralRed: 33, green: 34, blue: 65).cgColor,
            UIColor(integralRed: 44, green: 48, blue: 89).cgColor,
        ]
        let colors2 = [
            UIColor(integralRed: 63, green: 166, blue: 255).cgColor,
            UIColor(integralRed: 63, green: 166, blue: 255).cgColor,
        ]
        container.gradientLayer.colors = element.isSelected ? colors2 : colors1
    }
}

// MARK: Private
private extension ExchangesCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension ExchangesCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ExchangesCollectionCell {
    func makeContainer() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.cornerRadius = 15.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
