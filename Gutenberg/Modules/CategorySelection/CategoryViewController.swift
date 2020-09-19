//
//  CategoryViewController.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 18/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {
    // MARK: Outlet
    @IBOutlet weak var categoryTableVIew: UITableView!
    
    // MARK: Properties
    override var prefersStatusBarHidden: Bool {
        return true
    }
    private var categories = [BookCategories.fiction, .drama, .humor, .politics, .philosophy, .history, .adventure]

    // MARK: View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar(title: String.empty)
    }
    
    // MARK: Custom methods
    // Initialize view
    private func initializeView() {
        self.categoryTableVIew.register(CategoryTableViewCell.self)
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(category: self.categories[indexPath.row])
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.navigateToCategoryBooks(category: self.categories[indexPath.row])
    }
}
