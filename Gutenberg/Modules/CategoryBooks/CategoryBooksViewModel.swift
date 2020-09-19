//
//  CategoryBooksViewModel.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 19/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

protocol CategoryBooksViewModelInput {
    func getCategoryBooks()
    func getNextPage()
    func search(string: String)
    func getUrlForBook(book: Book) -> String?
}

protocol CategoryBooksViewModelOutput {
    var category: BookCategories { get }
    var booksCompletion: (() -> ())? { get set }
    var books: [Book] { get }
    var searchBooks: [Book] { get }
    var updateAfterNextPage: (([IndexPath]) -> ())? { get set }
    var isSearchActive: Bool { get set }
}

protocol CategoryBooksViewModelProtocol: CategoryBooksViewModelInput, CategoryBooksViewModelOutput { }

class CategoryBooksViewModel: CategoryBooksViewModelProtocol {
    // MARK: Properties
    private (set) var category: BookCategories
    private var service: CategoryBooksServiceProtocol
    private (set) var books: [Book] = [] {
        didSet {
            self.booksCompletion?()
        }
    }
    private (set) var searchBooks: [Book] = [] {
        didSet {
            self.booksCompletion?()
        }
    }
    private var nextUrl: URL?
    private var isNextAvailable = true
    var booksCompletion: (()->())?
    var updateAfterNextPage: (([IndexPath])->())?
    var isSearchActive = false
    
    // MARK: Init
    init(category: BookCategories) {
        self.category = category
        self.service = CategoryBooksService()
    }
    
    func getCategoryBooks() {
        let queryItems = [URLQueryItem(name: QueryParameters.page.key, value: "1"), URLQueryItem(name: QueryParameters.topic.key, value: self.category.title.lowercased()), URLQueryItem(name: QueryParameters.mimeType.key, value: Format.CodingKeys.imagejpeg.rawValue)]
        if var urlComps = URLComponents(string: AppUrls.books) {
            urlComps.queryItems = queryItems
            if let url = urlComps.url {
                self.service.getCategoryBooks(url: url) { [weak self] (books) in
                    self?.setNextUrl(next: books.next)
                    self?.books = books.results
                }
            }
        }
    }
    
    // Call for getting next page
    func getNextPage() {
        if let url = self.nextUrl {
            self.service.getCategoryBooks(url: url) { [weak self] (books) in
                self?.setNextUrl(next: books.next)
                let indexpaths = books.results.enumerated().map { (index, _) in
                    return (IndexPath(row: (self?.books.count ?? 0 - 1) + index, section: 0))
                }
                self?.books.append(contentsOf: books.results)
                self?.updateAfterNextPage?(indexpaths)
                if books.count == self?.books.count {
                    self?.nextUrl = nil
                }
                print("Total \(books.count), Count \(self?.books.count)")
            }
        }
    }
    
    // Set next url after getting response
    private func setNextUrl(next: String?) {
        self.nextUrl = next == nil ? nil : URL(string: next ?? String.empty)
    }
    
    // Search
    func search(string: String) {
        let queryItems = [URLQueryItem(name: QueryParameters.page.key, value: "1"), URLQueryItem(name: QueryParameters.topic.key, value: self.category.title.lowercased()), URLQueryItem(name: QueryParameters.mimeType.key, value: Format.CodingKeys.imagejpeg.rawValue), URLQueryItem(name: QueryParameters.search.key, value: string.lowercased())]
        if var urlComps = URLComponents(string: AppUrls.books) {
            urlComps.queryItems = queryItems
            if let url = urlComps.url {
                self.service.getCategoryBooks(url: url) { [weak self] (books) in
                    self?.setNextUrl(next: books.next)
                    self?.searchBooks = books.results
                }
            }
        }
    }
    
    // Get url for book
    func getUrlForBook(book: Book) -> String? {
        if book.formats?.texthtmlcharsetutf8 == nil && book.formats?.textplain == nil && book.formats?.pdf == nil && book.formats?.textplaincharsetutf8 == nil {
            return nil
        }
        if let htmlUrl = book.formats?.texthtmlcharsetutf8 {
            return htmlUrl
        }
        if let pdfUrl = book.formats?.pdf {
            return pdfUrl
        }
        if let plainUrl = book.formats?.textplaincharsetutf8 {
            return plainUrl
        }
        return book.formats?.textplain
    }
}
