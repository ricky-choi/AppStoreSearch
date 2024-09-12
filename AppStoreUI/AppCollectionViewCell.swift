//
//  AppCollectionViewCell.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.fillToSuperview(directionalInsets: .init(top: 15, leading: 10, bottom: 15, trailing: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model: AppUIModel) {
        label.text = model.appName
    }
}
