//
//  CategoryTableViewCell.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 18/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    // MARK: Outlet
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func setup(category: BookCategories) {
        self.containerView.addShadow(radius: 4)
        self.categoryTitle.text = category.title
        self.categoryImageView.image = category.image
    }
}
