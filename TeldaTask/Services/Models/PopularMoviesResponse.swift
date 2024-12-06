//
//  PopularMoviesResponse.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation

// MARK: - MoviesResponse
struct PopularMoviesResponse: Codable {
    let page: Int?
    let results: [MovieDetailsResponse]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

