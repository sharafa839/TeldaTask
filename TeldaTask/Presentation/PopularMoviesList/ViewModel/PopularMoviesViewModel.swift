//
//  PopularMoviesViewModel.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation
import Combine


internal final class PopularMoviesViewModel {
    
    let onLoading: CurrentValueSubject<Bool, Never> = .init(false)
    let onError: PassthroughSubject<String, Never> = .init()
    let currentPage: CurrentValueSubject<Int, Never> = .init(1)
    let moviesUseCase: PopularMoviesUseCaseProtocol
    let popularMovies: CurrentValueSubject<[PopularMovies]?, Never> = .init(nil)
    let moviesProperties: CurrentValueSubject<[PopularMovies], Never> = .init([])
    private (set) var allMoviesProperties: [PopularMovies] = []
    var searchTimer: Timer?
    let searchDelay: TimeInterval = 1
    
    init(moviesUseCase: PopularMoviesUseCaseProtocol = PopularMoviesUseCase()) {
        self.moviesUseCase = moviesUseCase
        getPopularMovies()
    }
    
    deinit {
        print("deinit\(Self.self)")
    }
    
    func getPopularMovies() {
        onLoading.send(true)
        moviesUseCase.getPopularMovies() { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let movies):
                allMoviesProperties.append(movies)
                popularMovies.send(allMoviesProperties)
                moviesProperties.send(allMoviesProperties)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
    
    func resetData() {
        allMoviesProperties = []
        moviesProperties.send([])
        moviesProperties.send(popularMovies.value ?? [])
        currentPage.send(1)
    }
    
    func throttleSearchWith(_ title: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false) { [weak self] _ in
            self?.searchMovieWith(title)
        }
    }
    
    func searchMovieWith(_ title: String) {
        moviesUseCase.searchMovie(with: title) { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let movies):
                allMoviesProperties = []
                moviesProperties.send([])
                allMoviesProperties.append(contentsOf: movies)
                moviesProperties.send(allMoviesProperties)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
}
