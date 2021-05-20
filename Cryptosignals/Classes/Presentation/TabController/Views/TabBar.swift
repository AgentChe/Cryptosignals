//
//  TabBar.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit

final class TabBar: UIView {
    enum Tab {
        case closedSignals, openedSignals, news
    }
    
    lazy var closedSignalsItem = makeItem(image: "TabBar.CloseSignals", title: "TabBar.ClosedSignals")
    lazy var openedSignalsItem = makeItem(image: "TabBar.OpenSignals", title: "TabBar.OpenSignals")
    lazy var newsItem = makeItem(image: "TabBar.News", title: "TabBar.News")
    
    var selectedTab = Tab.closedSignals {
        didSet {
            update()
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

// MARK: Private
private extension TabBar {
    func update() {
        [
            closedSignalsItem, openedSignalsItem, newsItem
        ]
        .forEach {
            $0.state = .deselected
        }
        
        switch selectedTab {
        case .closedSignals:
            closedSignalsItem.state = .selected
        case .openedSignals:
            openedSignalsItem.state = .selected
        case .news:
            newsItem.state = .selected
        }
    }
}

// MARK: Make constraints
private extension TabBar {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            closedSignalsItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            closedSignalsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            closedSignalsItem.topAnchor.constraint(equalTo: topAnchor),
            closedSignalsItem.widthAnchor.constraint(equalTo: openedSignalsItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            openedSignalsItem.leadingAnchor.constraint(equalTo: closedSignalsItem.trailingAnchor),
            openedSignalsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            openedSignalsItem.topAnchor.constraint(equalTo: topAnchor),
            openedSignalsItem.widthAnchor.constraint(equalTo: newsItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsItem.leadingAnchor.constraint(equalTo: openedSignalsItem.trailingAnchor),
            newsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            newsItem.topAnchor.constraint(equalTo: topAnchor),
            newsItem.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TabBar {
    func makeItem(image: String, title: String) -> TabItemView {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.regular(size: 12.scale))
            .lineHeight(13.scale)
            .textAlignment(.center)
            .textColor(UIColor(integralRed: 63, green: 166, blue: 255))
        
        let view = TabItemView()
        view.backgroundColor = UIColor.clear
        view.imageView.image = UIImage(named: image)
        view.label.attributedText = title.localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
