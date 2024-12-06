//
//  MoviesDetailsResponse.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import Foundation

// MARK: - Result
struct MovieDetailsResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?
    let status: String?
    let revenue: Int?
    let tagline: String?
    let genres: [Genre]?
    let belongsToCollection: BelongsToCollection?
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case runtime, status
        case tagline, revenue, genres
        case belongsToCollection = "belongs_to_collection"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let backdropPath: String?
    let id: Int?
    let name, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case posterPath = "poster_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
