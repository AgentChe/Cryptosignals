//
//  TopicsCollectionView.swift
//  CDL
//
//  Created by Andrey Chernyshev on 22.04.2021.
//

import UIKit

protocol CurrenciesCollectionViewDelegate: class {
    func currenciesCollectionViewDidChangeSelection()
}

final class CurrenciesCollectionView: UICollectionView {
    weak var currenciesCollectionViewDelegate: CurrenciesCollectionViewDelegate?
    
    lazy var elements = [CurrenciesCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: API
extension CurrenciesCollectionView {
    func setup(elements: [CurrenciesCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension CurrenciesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: CurrenciesCollectionCell.self), for: indexPath) as! CurrenciesCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CurrenciesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        elements[indexPath.row].isSelected = !elements[indexPath.row].isSelected
        
        reloadItems(at: [indexPath])
        
        currenciesCollectionViewDelegate?.currenciesCollectionViewDidChangeSelection()
    }
}

// MARK: CurrenciesCollectionLayoutDelegate
extension CurrenciesCollectionView: CurrenciesCollectionLayoutDelegate {
    func currenciesCollectionLayout(widthFor indexPath: IndexPath) -> CGFloat {
        return elements[indexPath.item].width(for: 40.scale)
    }
}

// MARK: Private
private extension CurrenciesCollectionView {
    func initialize() {
        register(CurrenciesCollectionCell.self, forCellWithReuseIdentifier: String(describing: CurrenciesCollectionCell.self))
        
        dataSource = self
        delegate = self
        
        if let currenciesLayout = collectionViewLayout as? CurrenciesCollectionLayout {
            currenciesLayout.delegate = self
        }
    }
}
