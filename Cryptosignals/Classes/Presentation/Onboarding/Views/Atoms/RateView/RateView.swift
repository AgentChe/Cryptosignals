//
//  RateView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 31.05.2021.
//

import UIKit

final class RateView: UIView {
    lazy var largeCircle: RateCircleView = {
        let view = RateCircleView()
        view.frame.size = CGSize(width: ScreenSize.isIphoneXFamily ? 183.scale : 153.scale,
                                 height: ScreenSize.isIphoneXFamily ? 183.scale : 153.scale)
        view.frame.origin = CGPoint(x: 96.scale, y: 0)
        view.pieBackgroundColor = UIColor(integralRed: 49, green: 115, blue: 180)
        view.pieFilledColor = UIColor(integralRed: 169, green: 40, blue: 100)
        view.backgroundColor = UIColor.clear
        addSubview(view)
        return view
    }()
    
    lazy var smallCircle: RateCircleView = {
        let view = RateCircleView()
        view.frame.size = CGSize(width: ScreenSize.isIphoneXFamily ? 135.scale : 105.scale,
                                 height: ScreenSize.isIphoneXFamily ? 135.scale : 105.scale)
        view.frame.origin = CGPoint(x: 120.scale, y: 24.scale)
        view.pieBackgroundColor = UIColor(integralRed: 63, green: 166, blue: 255)
        view.pieFilledColor = UIColor(integralRed: 250, green: 49, blue: 129)
        view.backgroundColor = UIColor.clear
        addSubview(view)
        return view
    }()
    
    lazy var winRateLabel: UILabel = {
        let view = UILabel()
        view.frame.origin = CGPoint(x: 54.scale, y: 127.scale)
        view.layer.cornerRadius = 10.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 33, green: 34, blue: 65)
        view.alpha = 0.9
        addSubview(view)
        return view
    }()
    
    lazy var loseRateLabel: UILabel = {
        let view = UILabel()
        view.frame.origin = CGPoint(x: 205.scale, y: 26.scale)
        view.layer.cornerRadius = 10.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 33, green: 34, blue: 65)
        view.alpha = 0.9
        addSubview(view)
        return view
    }()
    
    // 1, 2, 3, 4, 5, 10, 20
    func setup(value: Int) {
        largeCircle.value = value
        smallCircle.value = value
        
        let transformedValue = transformToString(value: value)
        
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .textColor(UIColor.white)
            .textAlignment(.center)
            .letterSpacing(0.37.scale)
        
        let winRateAttrs = String(format: "Onboarding.Risk.WinRate".localized, transformedValue.win).attributed(with: attrs)
        winRateLabel.attributedText = winRateAttrs
        var winRateSize = winRateAttrs.size()
        winRateSize.width += 24.scale
        winRateSize.height += 20.scale
        winRateLabel.frame.size = winRateSize
        
        let loseRateAttrs = String(format: "Onboarding.Risk.LoseRate".localized, transformedValue.lose).attributed(with: attrs)
        loseRateLabel.attributedText = loseRateAttrs
        var loseRateSize = loseRateAttrs.size()
        loseRateSize.width += 24.scale
        loseRateSize.height += 20.scale
        loseRateLabel.frame.size = loseRateSize
    }
}

// MARK: Private
private extension RateView {
    func transformToString(value: Int) -> (win: String, lose: String) {
        switch value {
        case 1:
            return ("50.00", "50.00")
        case 2:
            return ("33.33", "66.67")
        case 3:
            return ("25.00", "75.00")
        case 4:
            return ("20.00", "80.00")
        case 5:
            return ("16.67", "83.33")
        case 10:
            return ("9.09", "90.91")
        case 20:
            return ("4.76", "95.24")
        default:
            return ("", "")
        }
    }
}
