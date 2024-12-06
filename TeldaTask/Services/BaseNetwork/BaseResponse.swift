//
//  BaseResponse.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import Foundation
struct BaseResponse<T: Codable>: Codable {
    let result: T
}
