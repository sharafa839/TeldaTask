//
//  SearchMoviesResponse.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import Foundation

// MARK: - SearchMoviesResponse
struct SearchMoviesResponse: Codable {
    let results: [MovieDetailsResponse]?
    let totalPages, totalResults, page: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page
    }
}

