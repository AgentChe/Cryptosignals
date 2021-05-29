//
//  STExchangesCollectionView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class STExchangesCollectionView: UICollectionView {
    lazy var elements = [STExchangesCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: API
extension STExchangesCollectionView {
    func setup(elements: [STExchangesCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension STExchangesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: STExchangesCollectionCell.self), for: indexPath) as! STExchangesCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension STExchangesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .letterSpacing(0.37.scale)
            .textAlignment(.center)
        
        let string = elements[indexPath.row].exchange.name
        
        let width = string.attributed(with: attrs).size().width + 48.scale
        
        return CGSize(width: width, height: 36.scale)
    }
}

// MARK: Private
private extension STExchangesCollectionView {
    func initialize() {
        register(STExchangesCollectionCell.self, forCellWithReuseIdentifier: String(describing: STExchangesCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
