//
//  Filteration.swift
//  TeldaTask
//
//  Created by Sharaf on 8/6/24.
//

import Foundation

struct Filtration {
    let filter: Status
    var selected: Bool
}

extension Filtration: Equatable {
    static var allCases: [Filtration] {
        [.init(filter: .alive, selected: false), .init(filter: .dead, selected: false), .init(filter: .unknown, selected: false)]
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.filter == rhs.filter
    }
}
