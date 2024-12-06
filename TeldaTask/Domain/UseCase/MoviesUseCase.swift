//
//  GetPopularMoviesUseCase.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation

protocol PopularMoviesUseCaseProtocol {
    func getPopularMovies(completion: @escaping(Result<PopularMovies, Error>)-> Void)
    func searchMovie(with title: String, completion: @escaping(Result<[PopularMovies], Error>)-> Void)
    func getMovieDetails(with id: String, completion: @escaping(Result<MoviesProperties, Error>)-> Void)
    func getSimilarMovies(with id: String, completion: @escaping(Result<[MoviesProperties], Error>)->Void)
    func getMovieCredits(with id: String, completion: @escaping(Result<Crew, Error>)->Void)
}

internal final class PopularMoviesUseCase: PopularMoviesUseCaseProtocol {
   
    //MARK: - Properties
    let repo: MoviesNetworkingProtocol
    
    //MARK: - Init
    init(repo: MoviesNetworkingProtocol = MoviesRepo()) {
        self.repo = repo
    }
    
    //MARK: - Methods
    
    func getPopularMovies(completion: @escaping(Result<PopularMovies, Error>)-> Void) {
        repo.getPopularMovies() { [weak self] value in
            switch value {
            case .success(let response):
                completion(.success(PopularMovies(year: nil, groupedMovies: (response.results?.compactMap({MoviesProperties(model: $0)}))!)))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchMovie(with title: String, completion: @escaping (Result<[PopularMovies], Error>) -> Void) {
        repo.getSearchMovie(with: title) { [weak self] value in
            switch value {
            case .success(let response):
                guard let searchMovies = self?.groupMoviesByYear(movies: response) else { return }
                completion(.success(searchMovies))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetails(with id: String, completion: @escaping (Result<MoviesProperties, Error>) -> Void) {
        repo.getMovieDetails(with: id) { [weak self] value in
            switch value {
            case .success(let response):
                guard  let movieProperties = MoviesProperties(model: response) else { return }
                completion(.success(movieProperties))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSimilarMovies(with id: String, completion: @escaping(Result<[MoviesProperties], Error>)->Void) {
        repo.getSimilarMovies(with: id) { [weak self] value in
            switch value {
            case .success(let response):
                
                completion(.success((response.results?.compactMap({MoviesProperties(model: $0)}))!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieCredits(with id: String, completion: @escaping(Result<Crew, Error>)->Void) {
        repo.getMovieCredits(with: id) { [weak self] value in
            switch value {
            case .success(let response):
               
                guard let crew = self?.groupCrewByDepartment(crew: response) else { return }
                completion(.success(crew))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func groupMoviesByYear(movies: PopularMoviesResponse) -> [PopularMovies] {
        var groupedDict: [String: [MoviesProperties]] = [:]

        for movie in movies.results ?? [] {
            let year = String(movie.releaseDate!.prefix(4))
            if groupedDict[year] != nil {
                groupedDict[year]?.append(MoviesProperties(model: movie)!)
            } else {
                groupedDict[year] = [MoviesProperties(model: movie)!]
            }
        }
        
        let popularMovies = groupedDict.compactMap({PopularMovies(year: $0.key, groupedMovies: $0.value)})
        let orderedMoviesByYear = popularMovies.sorted(by: {$0.year! > $1.year!})
        return orderedMoviesByYear
    }
    
    private func groupCrewByDepartment(crew: CreditsMoviesResponse)-> Crew {
        let actors = crew.cast?.sorted(by: {$0.popularity ?? 0 > $1.popularity ?? 0}).filter({$0.knownForDepartment == "Acting"}).compactMap({Cast(model: $0)})
        let directors = crew.crew?.sorted(by: {$0.popularity ?? 0 > $1.popularity ?? 0}).filter({$0.department == "Directing"}).compactMap({Cast(model: $0)})
        let crew = Crew(actors: actors ?? [], directors: directors ?? [])
        return crew
    }
}
