//
//  STAllExchangesTableView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class STAllExchangesTableView: UITableView {
    var changeSelection: (() -> Void)?
    
    lazy var elements = [STExchangesCollectionElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension STAllExchangesTableView {
    func setup(elements: [STExchangesCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension STAllExchangesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: STAllExchangesTableCell.self)) as! STAllExchangesTableCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension STAllExchangesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        elements[indexPath.row].isSelected.toggle()
        
        reloadRows(at: [indexPath], with: .fade)
        
        changeSelection?()
    }
}

// MARK: Private
private extension STAllExchangesTableView {
    func initialize() {
        register(STAllExchangesTableCell.self, forCellReuseIdentifier: String(describing: STAllExchangesTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
