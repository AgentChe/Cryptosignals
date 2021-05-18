//
//  ExchangesCollectionView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import UIKit

protocol ExchangesCollectionViewDelegate: class {
    func exchangesCollectionViewDidChangeSelection()
}

final class ExchangesCollectionView: UICollectionView {
    lazy var elements = [ExchangesCollectionElement]()
    
    weak var exchangesCollectionViewDelegate: ExchangesCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: API
extension ExchangesCollectionView {
    func setup(elements: [ExchangesCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension ExchangesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: ExchangesCollectionCell.self), for: indexPath) as! ExchangesCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ExchangesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        elements[indexPath.row].isSelected.toggle()
        
        reloadItems(at: [indexPath])
        
        exchangesCollectionViewDelegate?.exchangesCollectionViewDidChangeSelection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: elements[indexPath.row].fullWidth ? 343.scale : 165.scale,
               height: 74.scale)
    }
}

// MARK: Private
private extension ExchangesCollectionView {
    func initialize() {
        register(ExchangesCollectionCell.self, forCellWithReuseIdentifier: String(describing: ExchangesCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
