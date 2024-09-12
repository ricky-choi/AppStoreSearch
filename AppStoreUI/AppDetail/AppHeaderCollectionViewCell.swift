//
//  AppHeaderCollectionViewCell.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/13/24.
//

import UIKit

class AppHeaderCollectionViewCell: UICollectionViewCell {
    
    let appIconView = UIImageView()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        appIconView.round()
        contentView.addSubview(appIconView)
        appIconView.translatesAutoresizingMaskIntoConstraints = false
        appIconView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        appIconView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        appIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        appIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        appIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        contentView.addSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.topAnchor.constraint(equalTo: appIconView.topAnchor).isActive = true
        appNameLabel.leadingAnchor.constraint(equalTo: appIconView.trailingAnchor, constant: 10).isActive = true
        appNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func setData(_ model: AppUIModel) {
        let iconURL: URL? = .init(string: model.appIconURL)
        appIconView.kf.setImage(with: iconURL)
        
        appNameLabel.text = model.appName
    }
}
