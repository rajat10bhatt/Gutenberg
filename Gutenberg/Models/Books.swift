//
//  Books.swift
//  Gutenberg
//
//  Created by Rajat Bhatt on 19/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

struct Books: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    var results: [Book] = []
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([Book].self, forKey: .results) ?? []
    }
}

// MARK: Book
struct Book: Codable {
    var authors: [Author] = []
    var bookshelves: [String] = []
    let downloadCount: Int?
    let formats: Format?
    let id: Int?
    var languages: [String] = []
    let mediaType: String?
    var subjects: [String] = []
    let title: String?

    enum CodingKeys: String, CodingKey {
        case authors
        case bookshelves
        case downloadCount = "download_count"
        case formats
        case id
        case languages
        case mediaType = "media_type"
        case subjects
        case title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        authors = try values.decodeIfPresent([Author].self, forKey: .authors) ?? []
        bookshelves = try values.decodeIfPresent([String].self, forKey: .bookshelves) ?? []
        downloadCount = try values.decodeIfPresent(Int.self, forKey: .downloadCount)
        formats = try values.decodeIfPresent(Format.self, forKey: .formats)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        languages = try values.decodeIfPresent([String].self, forKey: .languages) ?? []
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
        subjects = try values.decodeIfPresent([String].self, forKey: .subjects) ?? []
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

// MARK: Format
struct Format: Codable {
    let applicationzip: String?
    let textplain: String?
    let imagejpeg : String?
    let pdf: String?
    let texthtmlcharsetutf8 : String?
    let textplaincharsetutf8 : String?

    enum CodingKeys: String, CodingKey {
        case applicationzip = "application/zip"
        case textplain = "text/plain"
        case imagejpeg = "image/jpeg"
        case pdf = "application/pdf"
        case texthtmlcharsetutf8 = "text/html; charset=utf-8"
        case textplaincharsetutf8 = "text/plain; charset=utf-8"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        applicationzip = try values.decodeIfPresent(String.self, forKey: .applicationzip)
        textplain = try values.decodeIfPresent(String.self, forKey: .textplain)
        imagejpeg = try values.decodeIfPresent(String.self, forKey: .imagejpeg)
        pdf = try values.decodeIfPresent(String.self, forKey: .pdf)
        texthtmlcharsetutf8 = try values.decodeIfPresent(String.self, forKey: .texthtmlcharsetutf8)
        textplaincharsetutf8 = try values.decodeIfPresent(String.self, forKey: .textplaincharsetutf8)
    }
}

// MARK: Author
struct Author: Codable {
    let birthYear: Int?
    let deathYear: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case deathYear = "death_year"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        birthYear = try values.decodeIfPresent(Int.self, forKey: .birthYear)
        deathYear = try values.decodeIfPresent(Int.self, forKey: .deathYear)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
