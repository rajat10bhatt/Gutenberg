//
//  BaseViewController.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 18/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: Setup navigation
    func setupNavigationBar(title: String) {
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        if title == String.empty {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.368627451, green: 0.337254902, blue: 0.9058823529, alpha: 1)
            label.text = title
            label.font = UIFont.init(name: UIFont.Montserrat.semiBold, size: UIFont.Size.title)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
            self.navigationItem.leftItemsSupplementBackButton = true
            self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
            self.navigationController?.navigationBar.backItem?.title = String.empty
            self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.368627451, green: 0.337254902, blue: 0.9058823529, alpha: 1)
        }
    }
    
    // Show alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
