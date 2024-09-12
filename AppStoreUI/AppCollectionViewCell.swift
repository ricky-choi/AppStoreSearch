//
//  AppCollectionViewCell.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import UIKit
import Kingfisher

class AppCollectionViewCell: UICollectionViewCell {
    
    let appIconView = UIImageView()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    let screenShot0 = UIImageView()
    let screenShot1 = UIImageView()
    let screenShot2 = UIImageView()
    
    let starRatingView = StarRatingView()
    
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
        appIconView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        appIconView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        appIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        appIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        contentView.addSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.topAnchor.constraint(equalTo: appIconView.topAnchor).isActive = true
        appNameLabel.leadingAnchor.constraint(equalTo: appIconView.trailingAnchor, constant: 10).isActive = true
        appNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        contentView.addSubview(starRatingView)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        starRatingView.leadingAnchor.constraint(equalTo: appIconView.trailingAnchor, constant: 10).isActive = true
        starRatingView.bottomAnchor.constraint(equalTo: appIconView.bottomAnchor).isActive = true
        
        screenShot0.round()
        screenShot1.round()
        screenShot2.round()
        let stackView = UIStackView(arrangedSubviews: [screenShot0, screenShot1, screenShot2])
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: appIconView.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6).isActive = true
    }
    
    private func makeScreenShotImage(imageView: UIImageView) {
        imageView.round()
    }
    
    func setData(_ model: AppUIModel) {
        let iconURL: URL? = .init(string: model.appIconURL)
        appIconView.kf.setImage(with: iconURL)
        
        appNameLabel.text = model.appName
        
        starRatingView.rate = CGFloat(model.star)
        
        for (index, appScreenshotURL) in model.appScreenshotURLs.enumerated().prefix(3) {
            switch index {
            case 0:
                screenShot0.kf.setImage(with: URL(string: appScreenshotURL))
            case 1:
                screenShot1.kf.setImage(with: URL(string: appScreenshotURL))
            case 2:
                screenShot2.kf.setImage(with: URL(string: appScreenshotURL))
            default:
                break
            }
        }
    }
}

extension UIImageView {
    func round() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
        clipsToBounds = true
    }
}
