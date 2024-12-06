//
//  CreditsMoviesResponse.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import Foundation
// MARK: - CreditsMoviesResponse
struct CreditsMoviesResponse: Codable {
    let id: Int?
    let cast, crew: [CastResponses]?
}

// MARK: - Cast
struct CastResponses: Codable {
    let id: Int?
    let adult: Bool?
    let knownForDepartment: String?
    let profilePath: String?
    let popularity: Double?
    let castID: Int?
    let originalName, creditID: String?
    let order: Int?
    let character: String?
    let gender: Int?
    let name, department, job: String?

    enum CodingKeys: String, CodingKey {
        case id, adult
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case popularity
        case castID = "cast_id"
        case originalName = "original_name"
        case creditID = "credit_id"
        case order, character, gender, name, department, job
    }
}
