//
//  Base.swift
//  TeldaTask
//  Created by Sharaf on 12/4/24.
//

import Foundation

typealias Parameters = [String: Any]

//MARK: - Switch live to testing and the otherwise
enum NetworkServiceType {
    
    case live
    case test
}

public struct NetworkError: Error, LocalizedError, Codable {
    
    var code: Int = 0
    var message: String = ""
    
    public var localizedDescription: String {
        message
    }
    
    public var errorDescription: String? {
        message
    }
}
