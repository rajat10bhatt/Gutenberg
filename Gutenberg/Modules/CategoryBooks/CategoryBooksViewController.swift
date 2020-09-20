//
//  CategoryBooksViewController.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 18/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class CategoryBooksViewController: BaseViewController {
    // MARK: Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksCollectionView: UICollectionView!
    
    // MARK: Properties
    private var viewModel: CategoryBooksViewModelProtocol
    private var didTapDeleteKey = false
    private var isPageRefreshing = false
    private var isScrolling = false
    
    // MARK: View controller life cycle methods
    init?(coder: NSCoder, category: BookCategories) {
        self.viewModel = CategoryBooksViewModel(category: category)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    // MARK: Custom methods
    // Initialize view
    private func initializeView() {
        self.setupNavigationBar(title: viewModel.category.title)
        self.setupSearchBar()
        self.booksCollectionView.register(BookCollectionViewCell.self)
        self.observeBooksSuccess()
        self.observeNextPageSuccess()
        self.viewModel.getCategoryBooks()
    }
    
    // Setup search bar
    private func setupSearchBar() {
        self.searchBar.searchTextField.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.searchBar.searchTextField.font = UIFont(name: UIFont.Montserrat.regular, size: UIFont.Size.body)
        self.searchBar.setLeftImage(#imageLiteral(resourceName: "search"))
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.backgroundColor = UIColor.white
        self.searchBar.searchTextField.layer.cornerRadius = 4.0
        self.searchBar.searchTextField.layer.borderWidth = 1.0
        self.searchBar.searchTextField.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9647058824, alpha: 1)
        self.searchBar.searchTextField.borderStyle = .none
        self.searchBar.setImage(#imageLiteral(resourceName: "Cancel"), for: UISearchBar.Icon.clear, state: UIControl.State.normal)
        self.searchBar.setImage(#imageLiteral(resourceName: "Cancel"), for: UISearchBar.Icon.clear, state: UIControl.State.highlighted)
        self.searchBar.delegate = self
    }
    
    // MARK: Observers
    // Books success
    private func observeBooksSuccess() {
        viewModel.booksCompletion = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.booksCollectionView.reloadData()
            }
        }
    }
    
    // Next page success
    private func observeNextPageSuccess() {
        viewModel.updateAfterNextPage = { [weak self] indexPaths in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isPageRefreshing = false
                self.booksCollectionView.reloadData()
                self.booksCollectionView.layoutIfNeeded()
                if let indexPath = indexPaths.first {
                    self.booksCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
                }
            }
        }
    }
}

// MARK: UISearchBarDelegate
extension CategoryBooksViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.searchTextField.layer.borderColor = #colorLiteral(red: 0.368627451, green: 0.337254902, blue: 0.9058823529, alpha: 1)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.searchTextField.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9647058824, alpha: 1)
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let string = searchBar.text, !string.isEmpty {
            self.viewModel.isSearchActive = true
            self.viewModel.search(string: string)
        }
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.didTapDeleteKey = text.isEmpty
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !didTapDeleteKey && searchText.isEmpty {
            self.viewModel.isSearchActive = false
            self.booksCollectionView.reloadData()
        }
        didTapDeleteKey = false
    }
}

// MARK: UICollectionViewDelegate
extension CategoryBooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = self.viewModel.getUrlForBook(book: self.viewModel.books[indexPath.row])
        if url == nil {
            self.showAlert(title: "Error", message: "No viewable content available")
        } else {
            if let bookurl = URL(string: url ?? String.empty) {
                UIApplication.shared.open(bookurl)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension CategoryBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.isSearchActive {
            return self.viewModel.searchBooks.count
        }
        return self.viewModel.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if self.viewModel.isSearchActive {
            cell.setup(book: self.viewModel.searchBooks[indexPath.row])
        } else {
            cell.setup(book: self.viewModel.books[indexPath.row])
        }
        return cell
    }
}

// MARK: UIScrollViewDelegate
extension CategoryBooksViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.booksCollectionView.contentOffset.y + self.booksCollectionView.bounds.size.height > (self.booksCollectionView.contentSize.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                self.viewModel.getNextPage()
            }
        }
    }
}
