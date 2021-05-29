//
//  STAllExchangesView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class STAllExchangesView: UIView {
    lazy var searchView = makeSearchView()
    lazy var tableView = makeTableView()
    
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
private extension STAllExchangesView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 25, blue: 47)
    }
}

// MARK: Make constraints
private extension STAllExchangesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            searchView.heightAnchor.constraint(equalToConstant: 36.scale),
            searchView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 119.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 4.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension STAllExchangesView {
    func makeSearchView() -> SettinsSearchView {
        let view = SettinsSearchView()
        view.placeholder = "Settings.SearchExchanges".localized
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> STAllExchangesTableView {
        let view = STAllExchangesTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
