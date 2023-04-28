//
//  API.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import SwiftUI
import Moya

enum API {
    case search(query: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: Path.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let query):
            let param: [String:Any] = ["term": query, "entity": "musicVideo"]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .search:
            return ["Content-type": "application/json; charset=UTF-8", "Authorization": ""]
        }
    }
    
}
