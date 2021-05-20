//
//  NewTableTitleCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit

final class NewsTableTitleCell: UITableViewCell {
    lazy var titleLabel = maketTitleLabel()
    
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
extension NewsTableTitleCell {
    func setup(title: String) {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.bold(size: 27.scale))
            .lineHeight(32.scale)
            .textColor(UIColor.white)
            .letterSpacing(0.37.scale)
        titleLabel.attributedText = title.attributed(with: attrs)
    }
}

// MARK: Private
private extension NewsTableTitleCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension NewsTableTitleCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NewsTableTitleCell {
    func maketTitleLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
