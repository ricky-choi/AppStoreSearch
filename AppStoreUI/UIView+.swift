//
//  UIView+.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/13/24.
//

import UIKit

extension UIView {
    
    func fillToSuperview(directionalInsets: NSDirectionalEdgeInsets = .zero) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: directionalInsets.leading).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -directionalInsets.trailing).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: directionalInsets.top).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -directionalInsets.bottom).isActive = true
    }
    
    func round() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
        clipsToBounds = true
    }
}
