//
//  AppScreenshotCollectionViewCell.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/13/24.
//

import UIKit
import Kingfisher

class AppScreenshotCollectionViewCell: UICollectionViewCell {
    
    let screenShot = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        screenShot.round()
        contentView.addSubview(screenShot)
        screenShot.fillToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model: String) {
        screenShot.kf.setImage(with: URL(string: model))
    }
}
