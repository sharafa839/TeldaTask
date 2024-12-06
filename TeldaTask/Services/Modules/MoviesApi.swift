//
//  MoviesApi.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation
import Moya

enum MoviesApi {

    case getPopularMovies
    case searchMovie(by: String)
    case getMoviesDetails(withId: String)
    case getSimilarMovies(withId: String)
    case getMoviesCredits(withId: String)
}

extension MoviesApi: TargetType, BaseAPIHeadersProtocol {
    
    var path: String {
        switch self {
            case .getPopularMovies:
                return EndPoints.popularMovies.rawValue
            case .getMoviesCredits(let id):
                return EndPoints.getMoviesDetails.rawValue + id + "/credits"
            case .searchMovie:
                return EndPoints.searchMovies.rawValue
            case .getMoviesDetails(let id):
                return EndPoints.getMoviesDetails.rawValue + id
            case .getSimilarMovies(let id):
                return EndPoints.getMoviesDetails.rawValue + id + "/similar"
        }
    }
    
    var method: Moya.Method {
        switch self {
            default:
                return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPopularMovies:
            return .requestPlain
        case .searchMovie(let by):
            return .requestParameters(parameters: ["query": by], encoding: URLEncoding.default)
        case .getMoviesDetails:
            return .requestPlain
        case .getSimilarMovies:
            return .requestPlain    
        case .getMoviesCredits:
            return .requestPlain
        }
    }
}
