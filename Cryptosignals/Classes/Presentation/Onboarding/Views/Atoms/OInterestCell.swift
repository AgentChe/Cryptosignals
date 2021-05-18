//
//  OInterestCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import UIKit

final class OInterestCell: CircleView {
    lazy var label = makeLabel()
    
    var isSelected = false {
        didSet {
            update()
        }
    }
    
    var text: String = "" {
        didSet {
            let attrs = TextAttributes()
                .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
                .textColor(UIColor.white)
                .textAlignment(.center)
                .lineHeight(23.scale)
            label.attributedText = text.attributed(with: attrs)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OInterestCell {
    func update() {
        backgroundColor = isSelected ? UIColor(integralRed: 63, green: 166, blue: 255) : UIColor(integralRed: 33, green: 34, blue: 65)
    }
}

// MARK: Make constraints
private extension OInterestCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OInterestCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
