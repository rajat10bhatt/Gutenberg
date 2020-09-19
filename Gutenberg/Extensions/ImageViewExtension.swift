//
//  ImageViewExtension.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 19/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

extension UIImageView {
    // Shadow on image view
    func applyshadowWithCorner(containerView : UIView, cornerRadius : CGFloat) {
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = #colorLiteral(red: 0.8274509804, green: 0.8196078431, blue: 0.9333333333, alpha: 0.5)
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 8
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadius).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}

