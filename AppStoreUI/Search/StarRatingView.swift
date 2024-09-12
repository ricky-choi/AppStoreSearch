//
//  StarRatingView.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/13/24.
//

import UIKit

class StarRatingView: UIView {
    
    var rate: CGFloat = 0
    
    private let stackView = UIStackView(arrangedSubviews: [
        UIImageView(image: UIImage(systemName: "star")),
        UIImageView(image: UIImage(systemName: "star")),
        UIImageView(image: UIImage(systemName: "star")),
        UIImageView(image: UIImage(systemName: "star")),
        UIImageView(image: UIImage(systemName: "star")),
    ])
    
    private let stackViewFill = UIStackView(arrangedSubviews: [
        UIImageView(image: UIImage(systemName: "star.fill")),
        UIImageView(image: UIImage(systemName: "star.fill")),
        UIImageView(image: UIImage(systemName: "star.fill")),
        UIImageView(image: UIImage(systemName: "star.fill")),
        UIImageView(image: UIImage(systemName: "star.fill")),
    ])
    
    private let starMask = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor.darkGray
        
        addSubview(stackView)
        stackView.fillToSuperview()
        
        addSubview(stackViewFill)
        stackViewFill.fillToSuperview()
        
        starMask.backgroundColor = CGColor(gray: 1, alpha: 1)
        stackViewFill.layer.mask = starMask
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let adjustedRate: CGFloat = min(5, max(0, rate)) / 5.0
        starMask.frame = .init(x: 0, y: 0, width: bounds.width * adjustedRate, height: bounds.height)
    }

}
