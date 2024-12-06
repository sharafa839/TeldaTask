//
//  MoviesRepoProtocol.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation

protocol MoviesNetworkingProtocol {
    
    func getPopularMovies(completion: @escaping(Result<PopularMoviesResponse, Error>)->Void)
    
    func getSearchMovie(with title: String, completion: @escaping(Result<PopularMoviesResponse, Error>)->Void)
    
    func getMovieDetails(with id: String, completion: @escaping(Result<MovieDetailsResponse, Error>)->Void)
    
    func getSimilarMovies(with id: String, completion: @escaping(Result<PopularMoviesResponse, Error>)->Void)
    
    func getMovieCredits(with id: String, completion: @escaping(Result<CreditsMoviesResponse, Error>)->Void) 
}
