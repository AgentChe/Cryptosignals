//
//  SignalFilterView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 27.05.2021.
//

import UIKit

final class SignalFilterView: UIView {
    enum Filter {
        case today, yesterday, lastWeek, older
    }
    
    lazy var todayLabel = makeLabel(title: "Signals.Today", tag: 1)
    lazy var separator1 = makeSeparator()
    lazy var yesterdayLabel = makeLabel(title: "Signals.Yesterday", tag: 2)
    lazy var separator2 = makeSeparator()
    lazy var lastWeekLabel = makeLabel(title: "Signals.LastWeek", tag: 3)
    lazy var separator3 = makeSeparator()
    lazy var olderLabel = makeLabel(title: "Signals.Older", tag: 4)
    lazy var cursorView = makeCursor()
    
    lazy var filter = Filter.today {
        didSet {
            moveCursor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
        moveCursor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        moveCursor()
    }
}

// MARK: Private
private extension SignalFilterView {
    func initialize() {
        layer.cornerRadius = 9.scale
        
        backgroundColor = UIColor(integralRed: 33, green: 34, blue: 65)
    }
    
    func moveCursor() {
        let frontView: UIView
        
        switch filter {
        case .today:
            frontView = todayLabel
        case .yesterday:
            frontView = yesterdayLabel
        case .lastWeek:
            frontView = lastWeekLabel
        case .older:
            frontView = olderLabel
        }
        
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.cursorView.center = frontView.center
            self?.bringSubviewToFront(frontView)
        })
    }
}

// MARK: Make constraints
private extension SignalFilterView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            todayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            todayLabel.topAnchor.constraint(equalTo: topAnchor),
            todayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            todayLabel.widthAnchor.constraint(equalTo: yesterdayLabel.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 84.scale),
            separator1.centerYAnchor.constraint(equalTo: centerYAnchor),
            separator1.heightAnchor.constraint(equalToConstant: 16.scale),
            separator1.widthAnchor.constraint(equalToConstant: 1.scale)
        ])
        
        NSLayoutConstraint.activate([
            yesterdayLabel.leadingAnchor.constraint(equalTo: todayLabel.trailingAnchor),
            yesterdayLabel.topAnchor.constraint(equalTo: topAnchor),
            yesterdayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            yesterdayLabel.widthAnchor.constraint(equalTo: lastWeekLabel.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 169.scale),
            separator2.centerYAnchor.constraint(equalTo: centerYAnchor),
            separator2.heightAnchor.constraint(equalToConstant: 16.scale),
            separator2.widthAnchor.constraint(equalToConstant: 1.scale)
        ])
        
        NSLayoutConstraint.activate([
            lastWeekLabel.leadingAnchor.constraint(equalTo: yesterdayLabel.trailingAnchor),
            lastWeekLabel.topAnchor.constraint(equalTo: topAnchor),
            lastWeekLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            lastWeekLabel.widthAnchor.constraint(equalTo: olderLabel.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 253.scale),
            separator3.centerYAnchor.constraint(equalTo: centerYAnchor),
            separator3.heightAnchor.constraint(equalToConstant: 16.scale),
            separator3.widthAnchor.constraint(equalToConstant: 1.scale)
        ])
        
        NSLayoutConstraint.activate([
            olderLabel.leadingAnchor.constraint(equalTo: lastWeekLabel.trailingAnchor),
            olderLabel.topAnchor.constraint(equalTo: topAnchor),
            olderLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            olderLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SignalFilterView {
    func makeLabel(title: String, tag: Int) -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 13.scale))
            .lineHeight(18.scale)
            .letterSpacing(-0.08.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.tag = tag
        view.attributedText = title.localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 142, green: 142, blue: 147, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCursor() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 7.scale
        view.backgroundColor = UIColor(integralRed: 59, green: 61, blue: 107)
        view.frame.size = CGSize(width: 87.scale, height: 32.scale)
        addSubview(view)
        return view
    }
}
