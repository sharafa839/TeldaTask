//
//  CastModel.swift
//  TeldaTask
//
//  Created by Sharaf on 12/6/24.
//

import Foundation

struct Crew {
    let actors: [Cast]
    let directors: [Cast]
}

struct Cast {
    let id: Int
    let knownForDepartment: String
    let profilePath: String
    let originalName: String
    let popularity: Double
}

extension Cast {
    init?(model: CastResponses) {
        guard let id = model.id else { return nil }
        self.init(
            id: id,
            knownForDepartment: model.knownForDepartment ?? "",
            profilePath: Constants.baseImageUrl + "\(model.profilePath ?? "")",
            originalName: model.originalName ?? "",
            popularity: model.popularity ?? 0
        )
    }
}
