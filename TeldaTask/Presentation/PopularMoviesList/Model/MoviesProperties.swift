//
//  MoviesProperties.swift
//  TeldaTask
//
//  Created by Sharaf on 12/6/24.
//

import Foundation
class MoviesProperties {
    
    let id: Int
    let title: String
    let voteAverage: String
    let voteCount: String
    let popularity: String
    let originalTitle: String
    let overView: String
    let posterPath: String
    let releaseDate: String
    let tagLine: String
    let revenue: String
    let status: String
    var addToWashList: Bool
    
    init(
        id: Int,
        title: String,
        voteAverage: String,
        voteCount: String,
        popularity: String,
        originalTitle: String,
        overView: String,
        posterPath: String,
        releaseDate: String,
        tagLine: String,
        revenue: String,
        status: String,
        addToWashList: Bool
    ) {
        self.id = id
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.popularity = popularity
        self.originalTitle = originalTitle
        self.overView = overView
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.tagLine = tagLine
        self.revenue = revenue
        self.status = status
        self.addToWashList = addToWashList
    }
}

extension MoviesProperties {
    convenience init?(model: MovieDetailsResponse) {
        guard let id = model.id else { return nil }
        self.init(
            id: id,
            title: model.title ?? "",
            voteAverage: "\(model.voteAverage ?? 0)",
            voteCount: "\(model.voteCount ?? 0)",
            popularity: "\(model.popularity ?? 0)",
            originalTitle: model.originalTitle ?? "",
            overView: model.overview ?? "",
            posterPath: Constants.baseImageUrl + "\(model.posterPath ?? "")",
            releaseDate: model.releaseDate ?? "",
            tagLine: model.tagline ?? "",
            revenue: "\(model.revenue ?? 0)",
            status: model.status ?? "",
            addToWashList: false
        )
    }
}
