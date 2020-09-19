//
//  BookCollectionViewCell.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 19/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = UIImage()
    }
    
    // MARK: Setup
    func setup(book: Book) {
        self.titleLabel.text = book.title
        self.authorLabel.text = book.authors.first?.name
        self.coverImageView.applyshadowWithCorner(containerView: imageContainerView, cornerRadius: 8)
        if let imageURL = URL(string: book.formats?.imagejpeg ?? String.empty) {
            coverImageView.kf.setImage(with: imageURL)
        }
    }
}
