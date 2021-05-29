//
//  TokensTableViewCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class TokensTableViewCell: UITableViewCell {
    lazy var iconView = makeIconView()
    lazy var titleLabel = makeLabel()
    lazy var checkedView = makeIconView()
    lazy var separatorView = makeSeparator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TokensTableViewCell {
    func setup(element: TokensTableElement) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 20.scale))
            .lineHeight(22.scale)
            .letterSpacing(0.37.scale)
        titleLabel.attributedText = element.currency.code.attributed(with: attrs)
        
        checkedView.isHidden = !element.isSelected
    }
}

// MARK: Private
private extension TokensTableViewCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
        
        iconView.image = UIImage(named: "Settings.TokenIcon")
        checkedView.image = UIImage(named: "Settings.Checked")
    }
}

// MARK: Make constraints
private extension TokensTableViewCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 16.scale),
            iconView.heightAnchor.constraint(equalToConstant: 16.scale),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60.scale),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkedView.widthAnchor.constraint(equalToConstant: 24.scale),
            checkedView.heightAnchor.constraint(equalToConstant: 24.scale),
            checkedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            checkedView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            separatorView.heightAnchor.constraint(equalToConstant: 1.scale),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TokensTableViewCell {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 81, green: 85, blue: 149)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
