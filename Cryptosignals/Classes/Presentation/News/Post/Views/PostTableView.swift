//
//  PostTableView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import UIKit

protocol PostTableViewDelegate: class {
    func postTableDidTapped(id: Int)
}

final class PostTableView: UITableView {
    weak var postTableDelegate: PostTableViewDelegate?
    
    lazy var elements = [PostTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PostTableView {
    func setup(elements: [PostTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension PostTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .title(let title):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PostTableTitleCell.self)) as! PostTableTitleCell
            cell.setup(title: title)
            return cell
        case .header(let header):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PostTableHeaderCell.self)) as! PostTableHeaderCell
            cell.setup(header: header)
            return cell
        case .post(let post):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PostTablePostCell.self)) as! PostTablePostCell
            cell.setup(post: post)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension PostTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id: Int?
        switch elements[indexPath.row] {
        case .post(let post):
            id = post.id
        case .title, .header:
            id = nil
        }
        
        guard let _id = id else {
            return
        }
        
        postTableDelegate?.postTableDidTapped(id: _id)
    }
}

// MARK: Private
private extension PostTableView {
    func initialize() {
        register(PostTableTitleCell.self, forCellReuseIdentifier: String(describing: PostTableTitleCell.self))
        register(PostTableHeaderCell.self, forCellReuseIdentifier: String(describing: PostTableHeaderCell.self))
        register(PostTablePostCell.self, forCellReuseIdentifier: String(describing: PostTablePostCell.self))
        
        dataSource = self
        delegate = self
    }
}

