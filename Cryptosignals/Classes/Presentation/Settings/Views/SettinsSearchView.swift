//
//  SettinsSearchView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class SettinsSearchView: UIView {
    lazy var imageView = makeImageView()
    lazy var textField = makeTextField()
    
    lazy var placeholder: String = "" {
        didSet {
            let attrs = TextAttributes()
                .font(Fonts.SFProDisplay.regular(size: 17.scale))
                .lineHeight(21.scale)
                .textColor(UIColor(integralRed: 117, green: 122, blue: 174))
            textField.attributedPlaceholder = placeholder.attributed(with: attrs)
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
private extension SettinsSearchView {
    func initialize() {
        layer.cornerRadius = 10.scale
        
        backgroundColor = UIColor(integralRed: 81, green: 85, blue: 149, alpha: 0.5)
    }
}

// MARK: Make constraints
private extension SettinsSearchView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 14.scale),
            imageView.widthAnchor.constraint(equalToConstant: 14.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.scale),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SettinsSearchView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Settings.Search")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField() -> UITextField {
        let view = UITextField()
        view.textColor = UIColor.white
        view.font = Fonts.SFProDisplay.regular(size: 21.scale)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
