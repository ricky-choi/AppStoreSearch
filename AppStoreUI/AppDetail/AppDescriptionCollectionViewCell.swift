//
//  AppDescriptionCollectionViewCell.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/13/24.
//

import UIKit

class AppDescriptionCollectionViewCell: UICollectionViewCell {
    
    private var expanded: Bool = false {
        didSet {
            invalidateMoreButton()
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .tintColor
        let button = UIButton(configuration: config, primaryAction: .init(handler: { [weak self] _ in
            self?.label.numberOfLines = 0
            self?.invalidateIntrinsicContentSize()
            self?.expanded = true
        }))
        button.setTitle("더보기", for: .normal)
        button.isHidden = true
        return button
    }()
    
    var labelObservation: NSKeyValueObservation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.fillToSuperview(directionalInsets: .init(top: 15, leading: 10, bottom: 15, trailing: 10))
        
        contentView.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        labelObservation = label.observe(\.center) { [weak self] _, _ in
            self?.invalidateMoreButton()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model: String) {
        label.text = model
    }
    
    private func invalidateMoreButton() {
        if expanded {
            moreButton.isHidden = true
        } else {
            moreButton.isHidden = !label.isTextTruncated
        }
    }
}

extension UILabel {
    var isTextTruncated: Bool {
        guard let labelText = self.text else { return false }

        let labelSize = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)

        let attributes: [NSAttributedString.Key: Any] = [.font: self.font!]
        let textRect = (labelText as NSString).boundingRect(with: labelSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return textRect.size.height > self.bounds.size.height
    }
}
