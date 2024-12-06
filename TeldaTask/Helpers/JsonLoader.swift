//
//  JsonLoader.swift
//  Merchant
//
//  Created by Sharaf on 25/05/2022.
//  Copyright © 2022 Shgardi App. All rights reserved.
//

import Foundation
final class JSONLoader {
    
    class func load<T: Decodable>(name: String) throws -> T {
        guard let file = Bundle.main.url(forResource: name, withExtension: "json") else {
            throw NetworkError(code: 404, message: "Couldn't find \(name) in main bundle.")
        }
        
        let data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    class func loadData(file name: String) throws -> Data? {
        guard let file = Bundle.main.url(forResource: name, withExtension: "json") else {
            throw NetworkError(code: 404, message: "Couldn't find \(name) in main bundle.")
        }
        
        return try Data(contentsOf: file)
    }
}
