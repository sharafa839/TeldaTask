//
//  MovieDetailsViewModel.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation
import Combine

internal final class MovieDetailsViewModel {
    
    //MARK: - Properties
    let onLoading: CurrentValueSubject<Bool, Never> = .init(false)
    let onError: PassthroughSubject<String, Never> = .init()
    let movieProperties: MoviesProperties
    let movieUseCase: PopularMoviesUseCaseProtocol
    let moviePropertiesShown: CurrentValueSubject<MoviesProperties?, Never> = .init(nil)
    let similarMovies: CurrentValueSubject<[MoviesProperties], Never> = .init([])
    let crewOfMovies: CurrentValueSubject<Crew?, Never> = .init(nil)
    
    //MARK: - Init
    
    init(movieProperties: MoviesProperties, movieUseCase: PopularMoviesUseCaseProtocol = PopularMoviesUseCase()) {
        self.movieProperties = movieProperties
        self.movieUseCase = movieUseCase
        getMovieDetails()
        getSimilarMovies()
        getCreditsMovies()
    }
    
    private func getMovieDetails() {
        onLoading.send(true)
        movieUseCase.getMovieDetails(with: "\(movieProperties.id)") { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let response):
                moviePropertiesShown.send(response)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
    
    private func getSimilarMovies() {
        onLoading.send(true)
        movieUseCase.getSimilarMovies(with: "\(movieProperties.id)") { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let response):
                similarMovies.send(response)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
    
    private func getCreditsMovies() {
        onLoading.send(true)
        movieUseCase.getMovieCredits(with: "\(movieProperties.id)") { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let response):
                crewOfMovies.send(response)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
}
