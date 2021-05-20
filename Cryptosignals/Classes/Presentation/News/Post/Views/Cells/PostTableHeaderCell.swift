//
//  NewsTableFeatureCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit
import Kingfisher

final class PostTableHeaderCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    lazy var titleLabel = makeLabel()
    lazy var descriptionLabel = makeLabel()
    
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
extension PostTableHeaderCell {
    func setup(header: PostHeader) {
        pictureView.kf.cancelDownloadTask()
        pictureView.image = nil
        
        if let url = URL(string: header.imageUrl) {
            pictureView.kf.setImage(with: url)
        }
        
        let titleAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.bold(size: 28.scale))
            .lineHeight(33.scale)
            .textColor(UIColor.white)
            .letterSpacing(0.37.scale)
        titleLabel.attributedText = header.title.attributed(with: titleAttrs)
        
        descriptionLabel.attributedText = attributedString(for: header.html)
    }
    
    func attributedString(for htmlString: String) -> NSAttributedString? {
        guard !htmlString.isEmpty else { return nil }
        
        let font = Fonts.SFProDisplay.regular(size: 17.scale)
        let htmlWithStyle = "<span style=\"font-family: \(font.fontName); font-style: regular; color: white; font-size: \(font.pointSize); line-height: 23px;\">\(htmlString)</span>"
        let data = Data(htmlWithStyle.utf8)
        
        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        )
        
        return attributedString
    }
}

// MARK: Private
private extension PostTableHeaderCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension PostTableHeaderCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            pictureView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 256.scale)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.scale),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.scale),
            descriptionLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 16.scale),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PostTableHeaderCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
