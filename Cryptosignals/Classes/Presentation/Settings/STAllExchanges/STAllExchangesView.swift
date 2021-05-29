//
//  STAllExchangesView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class STAllExchangesView: UIView {
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
        
    }
}

// MARK: Lazy initialization
private extension STAllExchangesView {
    
}
