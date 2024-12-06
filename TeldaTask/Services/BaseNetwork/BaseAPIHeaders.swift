//
//  BaseAPIHeaders.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import Foundation

protocol BaseAPIHeadersProtocol {
    
    var headers: [String: String]? { get }
}

extension BaseAPIHeadersProtocol {
    
    var baseURL: URL {
        URL(string: Constants.baseUrl)!
    }
    
    var headers: [String : String]? {
        ["accept": "application/json", "language": "en-US", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTg2NmNmYzdhNWE0MTI2YzcwZWU0ODFiMDQ0YmNlNyIsIm5iZiI6MTYwOTgwMzc0NC4xMTAwMDAxLCJzdWIiOiI1ZmYzYTdlMDYzMzFiMjAwM2ZiMzBmZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.UEjn0lo3JDss-xTDBPzFpOuktTuHmtEDsvscX8nVoEE"]
    }
}

