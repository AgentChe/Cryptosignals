//
//  TokensTableView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class TokensTableView: UITableView {
    lazy var elements = [TokensTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TokensTableView {
    func setup(elements: [TokensTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension TokensTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: TokensTableViewCell.self)) as! TokensTableViewCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension TokensTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        16.scale
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        elements[indexPath.row].isSelected.toggle()
        
        reloadRows(at: [indexPath], with: .fade)
    }
}

// MARK: Private
private extension TokensTableView {
    func initialize() {
        register(TokensTableViewCell.self, forCellReuseIdentifier: String(describing: TokensTableViewCell.self))
        
        dataSource = self
        delegate = self
    }
}
