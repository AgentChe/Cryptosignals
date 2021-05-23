//
//  CryptoSignalsTableView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import UIKit

final class CryptoSignalsTableView: UITableView {
    lazy var elements = [CryptoSignalsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CryptoSignalsTableView {
    func setup(elements: [CryptoSignalsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension CryptoSignalsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: CryptoSignalsTableCell.self)) as! CryptoSignalsTableCell
        cell.setup(element: elements[indexPath.section])
        return cell
    }
}

// MARK: UITableViewDelegate
extension CryptoSignalsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        16.scale
    }
}

// MARK: Private
private extension CryptoSignalsTableView {
    func initialize() {
        register(CryptoSignalsTableCell.self, forCellReuseIdentifier: String(describing: CryptoSignalsTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
