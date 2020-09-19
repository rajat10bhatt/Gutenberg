//
//  CategoryBooksService.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 19/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

protocol CategoryBooksServiceProtocol {
    func getCategoryBooks(url: URL, completion: @escaping (Books)->())
}

class CategoryBooksService: CategoryBooksServiceProtocol {
    // Get books
    func getCategoryBooks(url: URL, completion: @escaping (Books)->()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let books = try JSONDecoder().decode(Books.self, from: unwrappedData)
                completion(books)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
