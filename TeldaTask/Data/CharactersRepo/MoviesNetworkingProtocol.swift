//
//  MoviesNetworkingProtocol.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation


extension MoviesNetworkingProtocol  {
    
    private var repo: MoviesRepo {
        return MoviesRepo()
    }
    
    func getPopularMovies(completion : @escaping(Result<PopularMoviesResponse, Error>)->Void) {
        repo.defaultRequest(target: .getPopularMovies, completion: completion)
    }
    
    func getSearchMovie(with title: String, completion: @escaping(Result<PopularMoviesResponse, Error>)->Void) {
        repo.defaultRequest(target: .searchMovie(by: title), completion: completion)
    }
    
    func getMovieDetails(with id: String, completion: @escaping(Result<MovieDetailsResponse, Error>)->Void) {
        repo.defaultRequest(target: .getMoviesDetails(withId: id), completion: completion)
    }

    func getSimilarMovies(with id: String, completion: @escaping(Result<PopularMoviesResponse, Error>)->Void) {
        repo.defaultRequest(target: .getSimilarMovies(withId: id), completion: completion)
    }
    
    func getMovieCredits(with id: String, completion: @escaping(Result<CreditsMoviesResponse, Error>)->Void) {
        repo.defaultRequest(target: .getMoviesCredits(withId: id), completion: completion)
    }

}
