//
//  PopularMoviesModel.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation

struct PopularMovies {
    let year: String?
    let groupedMovies: [MoviesProperties]
}

extension PopularMovies {
    init(movie: MovieDetailsResponse) {
        self.init(
            year: movie.releaseDate ?? "",
            groupedMovies: [.init(model: movie)!]
        )
    }
}

