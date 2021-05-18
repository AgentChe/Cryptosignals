//
//  TopicsCollectionCell.swift
//  CDL
//
//  Created by Andrey Chernyshev on 22.04.2021.
//

import UIKit

final class CurrenciesCollectionCell: UICollectionViewCell {
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
extension CurrenciesCollectionCell {
    func setup(element: CurrenciesCollectionElement) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(23.scale)
            .textAlignment(.center)
        label.attributedText = element.currency.name.attributed(with: attrs)
        
        container.layer.borderWidth = element.isSelected ? 0 : 2.scale
        container.layer.borderColor = element.isSelected ? UIColor.clear.cgColor : UIColor(integralRed: 44, green: 48, blue: 89).cgColor
        container.backgroundColor = element.isSelected ? UIColor(integralRed: 63, green: 166, blue: 255) : UIColor.clear
    }
    
    static func size(for element: CurrenciesCollectionElement, with height: CGFloat) -> CGSize {
        sizingCell.setup(element: element)
        return sizingCell.contentView.systemLayoutSizeFitting(
            CGSize(width: UIView.layoutFittingCompressedSize.width, height: height),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
    }
    
    private static let sizingCell = CurrenciesCollectionCell()
}

// MARK: Private
private extension CurrenciesCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension CurrenciesCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CurrenciesCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
