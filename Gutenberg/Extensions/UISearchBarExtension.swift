//
//  UISearchBarExtension.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 18/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

extension UISearchBar {
    // Set left image
    func setLeftImage(_ image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.searchTextField.leftView = imageView
    }
    
    // Set right image
    func setRightImage(normalImage: UIImage, highLightedImage: UIImage) {
        showsBookmarkButton = true
        if let btn = searchTextField.rightView as? UIButton {
            btn.setImage(normalImage, for: .normal)
            btn.setImage(highLightedImage, for: .highlighted)
        }
    }
}
