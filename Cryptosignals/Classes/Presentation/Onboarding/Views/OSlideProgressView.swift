//
//  OSlideProgressView.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 19.05.2021.
//

import UIKit

final class OSlideProgressView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var progressView = makeProgressView()
    lazy var cell1 = makeCell(title: "Onboarding.Progress.Cell1")
    lazy var cell2 = makeCell(title: "Onboarding.Progress.Cell2")
    lazy var cell3 = makeCell(title: "Onboarding.Progress.Cell3")
    
    private var animation: CABasicAnimation?
    private var timer: Timer?
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        rotate()
        calculatePercent()
    }
}

// MARK: Private
private extension OSlideProgressView {
    func rotate() {
        animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        guard let animationLayer = animation else {
            return
        }
        
        animationLayer.toValue = NSNumber(value: Double.pi * 2)
        animationLayer.duration = 1
        animationLayer.isCumulative = true
        animationLayer.repeatCount = Float.greatestFiniteMagnitude
        progressView.layer.add(animationLayer, forKey: "rotationAnimation")
    }
    
    func calculatePercent() {
        let duration = Double(5)
        var seconds = Double(0)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            seconds += 0.1
            
            var percent = Int(seconds / duration * 100)
            if percent > 100 {
                percent = 100
            }
            
            if percent <= 33 {
                self?.cell1.isSelected = true
            } else if percent <= 66 {
                self?.cell2.isSelected = true
            }  else {
                self?.cell3.isSelected = true
            }
            
            if seconds >= duration {
                timer.invalidate()
                
                self?.finish()
            }
        }
    }
    
    func finish() {
        progressView.layer.removeAnimation(forKey: "rotationAnimation")
        animation = nil
        
        timer = nil
        
        onNext()
    }
}

// MARK: Make constraints
private extension OSlideProgressView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 174.scale : 100.scale)
        ])
        
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: 150.scale),
            progressView.heightAnchor.constraint(equalToConstant: 150.scale),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 51.scale : 66.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76.scale),
            cell1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.scale),
            cell1.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 49.scale : 66.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76.scale),
            cell2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.scale),
            cell2.topAnchor.constraint(equalTo: cell1.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76.scale),
            cell3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.scale),
            cell3.topAnchor.constraint(equalTo: cell2.bottomAnchor, constant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OSlideProgressView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 28.scale))
            .lineHeight(33.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Progress.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProgressView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Onboarding.Progress.Preloader")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(title: String) -> OProgressCell {
        let view = OProgressCell()
        view.title = title.localized
        view.isSelected = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
