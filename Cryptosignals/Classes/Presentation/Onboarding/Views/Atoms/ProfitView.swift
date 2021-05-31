//
//  ProfitView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 29.05.2021.
//

import UIKit

final class ProfitView: UIView {
    // 1, 2, 3, 4, 5, 10, 20
    var profit: Int = 1 {
        didSet {
            update()
        }
    }
    
    lazy var towersViews = makeTowersViews()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        update()
    }
}

// MARK: Private
private extension ProfitView {
    func update() {
        towersViews.forEach {
            $0.backgroundColor = UIColor(integralRed: 81, green: 85, blue: 149, alpha: 0.2)
        }
        
        var views = [UIView]()
        
        switch profit {
        case 1:
            views = Array(towersViews.prefix(4))
        case 2:
            views = Array(towersViews.prefix(8))
        case 3:
            views = Array(towersViews.prefix(12))
        case 4:
            views = Array(towersViews.prefix(16))
        case 5:
            views = Array(towersViews.prefix(20))
        case 10:
            views = Array(towersViews.prefix(26))
        case 20:
            views = towersViews
        default:
            break
        }
        
        views.forEach {
            $0.backgroundColor = UIColor(integralRed: 63, green: 166, blue: 255)
        }
    }
    
    func makeTowersViews() -> [UIView] {
        var views = [UIView]()
        
        let containerHeight = 42.scale
        
        var x = CGFloat(0)
        
        for i in 11...42 {
            let view = UIView()
            view.frame.size = CGSize(width: 4.scale, height: i.scale)
            view.frame.origin = CGPoint(x: x, y: containerHeight - i.scale)
            views.append(view)
            
            addSubview(view)
            
            x += 4.scale + 6.scale
        }
        
        return views
    }
}
