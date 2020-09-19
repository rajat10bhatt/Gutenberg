//
//  Constants.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 18/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

// Book categories
enum BookCategories {
    case fiction, drama, humor, politics, philosophy, history, adventure
}

extension BookCategories {
    var title: String {
        switch self {
        case .fiction:
            return "FICTION"
        case .drama:
            return "DRAMA"
        case .humor:
            return "HUMOR"
        case .politics:
            return "POLITICS"
        case .philosophy:
            return "PHILOSOPHY"
        case .history:
            return "HISTORY"
        case .adventure:
            return "ADVENTURE"
        }
    }
    
    var image: UIImage {
        switch self {
        case .fiction:
            return #imageLiteral(resourceName: "Fiction")
        case .drama:
            return #imageLiteral(resourceName: "Drama")
        case .humor:
            return #imageLiteral(resourceName: "Humour")
        case .politics:
            return #imageLiteral(resourceName: "Politics")
        case .philosophy:
            return #imageLiteral(resourceName: "Philosophy")
        case .history:
            return #imageLiteral(resourceName: "History")
        case .adventure:
            return #imageLiteral(resourceName: "Adventure")
        }
    }
}

// MARK: Query parameters
enum QueryParameters: String {
    case page
    case topic
    case mimeType = "mime_type"
    case search
}

extension QueryParameters {
    var key: String {
        return self.rawValue
    }
}
