//
//  NewsTableFeatureCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit
import Kingfisher

final class NewsTableFeatureCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var pictureView = makeImageView()
    lazy var titleLabel = maketLabel()
    lazy var descriptionLabel = maketLabel()
    
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
extension NewsTableFeatureCell {
    func setup(feature: Feature) {
        pictureView.kf.cancelDownloadTask()
        pictureView.image = nil
        
        if let url = URL(string: feature.imageUrl) {
            pictureView.kf.setImage(with: url)
        }
        
        let titleAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.bold(size: 25.scale))
            .lineHeight(29.scale)
            .textColor(UIColor.white)
            .letterSpacing(0.37.scale)
        titleLabel.attributedText = feature.title.attributed(with: titleAttrs)
        
        let descriptionAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.scale)
            .textColor(UIColor.white)
            .letterSpacing(0.37.scale)
        descriptionLabel.attributedText = feature.description.attributed(with: descriptionAttrs)
    }
}

// MARK: Private
private extension NewsTableFeatureCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension NewsTableFeatureCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.scale)
        ])
        
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: container.topAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: 156.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.scale),
            titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.scale),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.scale),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.scale),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NewsTableFeatureCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 33, green: 34, blue: 65)
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func maketLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
