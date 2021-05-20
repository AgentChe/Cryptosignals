//
//  NewsTablePostCell.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit

final class NewsTablePostCell: UITableViewCell {lazy var pictureView = makeImageView()
    lazy var titleLabel = maketLabel()
    lazy var timeLabel = maketLabel()
    
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
extension NewsTablePostCell {
    func setup(post: Post) {
        pictureView.kf.cancelDownloadTask()
        pictureView.image = nil
        
        if let url = URL(string: post.imageUrl) {
            pictureView.kf.setImage(with: url)
        }
        
        let titleAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
            .textColor(UIColor.white)
            .letterSpacing(0.37.scale)
        titleLabel.attributedText = post.title.attributed(with: titleAttrs)
        
        let timeAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.regular(size: 13.scale))
            .lineHeight(15.scale)
            .textColor(UIColor(integralRed: 81, green: 85, blue: 149))
            .letterSpacing(0.37.scale)
        timeLabel.attributedText = post.time.attributed(with: timeAttrs)
    }
}

// MARK: Private
private extension NewsTablePostCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension NewsTablePostCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.widthAnchor.constraint(equalToConstant: 101.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 85.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 127.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 127.scale),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.scale),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NewsTablePostCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func maketLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
