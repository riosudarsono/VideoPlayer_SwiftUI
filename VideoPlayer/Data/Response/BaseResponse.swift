//
//  BaseResponse.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import Foundation

struct BaseResponse<T: Codable>: Decodable {
    var resultCount: Int?
    var results: T?
    
    init(results: T) {
        self.results = results
    }
}
