//
//  CryptoSignalsTableCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import UIKit

final class CryptoSignalsTableCell: UITableViewCell {
    lazy var container = makeContainer()
    
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
extension CryptoSignalsTableCell {
    func setup(element: CryptoSignalsTableElement) {
        
    }
}

// MARK: Private
private extension CryptoSignalsTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension CryptoSignalsTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 126.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CryptoSignalsTableCell {
    func makeContainer() -> GradientView {
        let view = GradientView()
        view.gradientLayer.colors = [
            UIColor(integralRed: 33, green: 34, blue: 65).cgColor,
            UIColor(integralRed: 44, green: 48, blue: 89).cgColor
        ]
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        view.layer.cornerRadius = 15.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
