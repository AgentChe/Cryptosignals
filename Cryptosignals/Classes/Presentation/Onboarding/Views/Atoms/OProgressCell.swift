//
//  OProgressCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 19.05.2021.
//

import UIKit

final class OProgressCell: UIView {
    lazy var titleLabel = makeLabel()
    lazy var imageView = makeImageView()
    
    var isSelected: Bool = false {
        didSet {
            imageView.image = UIImage(named: isSelected ? "Onboarding.Progress.Checked" : "Onboarding.Progress.Unchecked")
        }
    }
    
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor.white)
                .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
                .lineHeight(28.scale)
            titleLabel.attributedText = title.attributed(with: attrs)
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

// MARK: Make constraints
private extension OProgressCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24.scale),
            imageView.widthAnchor.constraint(equalToConstant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OProgressCell {
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
