//
//  NewsTableView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit

protocol NewsTableViewDelegate: class {
    func newsTableDidTapped(id: Int)
}

final class NewsTableView: UITableView {
    weak var newsTableDelegate: NewsTableViewDelegate?
    
    lazy var elements = [NewsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension NewsTableView {
    func setup(elements: [NewsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension NewsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .title(let title):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NewsTableTitleCell.self)) as! NewsTableTitleCell
            cell.setup(title: title)
            return cell
        case .feature(let feature):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NewsTableFeatureCell.self)) as! NewsTableFeatureCell
            cell.setup(feature: feature)
            return cell
        case .post(let post):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NewsTablePostCell.self)) as! NewsTablePostCell
            cell.setup(post: post)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension NewsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id: Int?
        switch elements[indexPath.row] {
        case .feature(let feature):
            id = feature.id
        case .post(let post):
            id = post.id
        case .title:
            id = nil
        }
        
        guard let _id = id else {
            return
        }
        
        newsTableDelegate?.newsTableDidTapped(id: _id)
    }
}

// MARK: Private
private extension NewsTableView {
    func initialize() {
        register(NewsTableTitleCell.self, forCellReuseIdentifier: String(describing: NewsTableTitleCell.self))
        register(NewsTableFeatureCell.self, forCellReuseIdentifier: String(describing: NewsTableFeatureCell.self))
        register(NewsTablePostCell.self, forCellReuseIdentifier: String(describing: NewsTablePostCell.self))
        
        dataSource = self
        delegate = self
    }
}
