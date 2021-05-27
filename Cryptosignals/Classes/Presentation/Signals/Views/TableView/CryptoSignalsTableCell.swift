//
//  CryptoSignalsTableCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import UIKit

final class CryptoSignalsTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var titleLabel = makeLabel()
    lazy var subTitleLabel = makeLabel()
    lazy var gainLabel = makeLabel()
    lazy var gainValueLabel = makeLabel()
    lazy var entryPointLabel = makeLabel()
    lazy var entryPointValueLabel = makeLabel()
    lazy var targetPriceLabel = makeLabel()
    lazy var targetPriceValueLabel = makeLabel()
    
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
        let currenciesAttrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 16.scale))
            .lineHeight(19.2.scale)
            .letterSpacing(0.37.scale)
        let currencies = element.currencies.attributed(with: currenciesAttrs)
        
        let typeAttrs = TextAttributes()
            .textColor(element.type == .long ? UIColor(integralRed: 17, green: 206, blue: 164) : UIColor(integralRed: 250, green: 49, blue: 129))
            .font(Fonts.SFProDisplay.bold(size: 13.scale))
            .lineHeight(15.6.scale)
            .letterSpacing(0.37.scale)
        let type: NSAttributedString
        switch element.type {
        case .long:
            type = "Signals.Long".localized.attributed(with: typeAttrs)
        case .short:
            type = "Signals.Short".localized.attributed(with: typeAttrs)
        }
        
        let title = NSMutableAttributedString()
        title.append(currencies)
        title.append(NSAttributedString(string: "  "))
        title.append(type)
        
        titleLabel.attributedText = title
        
        let subTitleAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 12.scale))
            .textColor(UIColor.white.withAlphaComponent(0.5))
            .lineHeight(14.32.scale)
            .letterSpacing(0.37.scale)
        subTitleLabel.attributedText = String(format: "Signals.SubTitle".localized, element.dateString, element.exchange).attributed(with: subTitleAttrs)
        
        let gainAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 13.scale))
            .lineHeight(15.51.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.right)
            .textColor(UIColor.white.withAlphaComponent(0.5))
        gainLabel.attributedText = "Signals.Gain".localized.attributed(with: gainAttrs)
        
        let gainValueAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.29.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.right)
            .textColor(UIColor(integralRed: 17, green: 206, blue: 164))
        gainValueLabel.attributedText = element.gain.attributed(with: gainValueAttrs)
        
        let entryPointAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 13.scale))
            .lineHeight(15.51.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.left)
            .textColor(UIColor.white.withAlphaComponent(0.5))
        entryPointLabel.attributedText = "Signals.EntryPoint".localized.attributed(with: entryPointAttrs)
        
        let entryPointValueAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.29.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.left)
            .textColor(UIColor.white)
        entryPointValueLabel.attributedText = element.entryPoint.attributed(with: entryPointValueAttrs)
        
        let targetPriceAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 13.scale))
            .lineHeight(15.51.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.left)
            .textColor(UIColor.white.withAlphaComponent(0.5))
        targetPriceLabel.attributedText = "Signals.TargetPrice".localized.attributed(with: targetPriceAttrs)
        
        let targetPriceValueAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.29.scale)
            .letterSpacing(0.37.scale)
            .textAlignment(.left)
            .textColor(UIColor.white)
        targetPriceValueLabel.attributedText = element.targetPrice.attributed(with: targetPriceValueAttrs)
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
            container.heightAnchor.constraint(equalToConstant: 178.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 36.scale),
            iconView.heightAnchor.constraint(equalToConstant: 36.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 59.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 15.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -45.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 59.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -70.scale)
        ])
        
        NSLayoutConstraint.activate([
            gainLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.scale),
            gainLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 17.scale)
        ])
        
        NSLayoutConstraint.activate([
            gainValueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.scale),
            gainValueLabel.topAnchor.constraint(equalTo: gainLabel.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            entryPointLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            entryPointLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            entryPointValueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            entryPointValueLabel.topAnchor.constraint(equalTo: entryPointLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            targetPriceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            targetPriceLabel.topAnchor.constraint(equalTo: entryPointValueLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            targetPriceValueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            targetPriceValueLabel.topAnchor.constraint(equalTo: targetPriceLabel.bottomAnchor, constant: 4.scale)
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
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Signals.CellIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
