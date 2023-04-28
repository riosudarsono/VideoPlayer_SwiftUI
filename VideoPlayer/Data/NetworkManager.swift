//
//  NetworkManager.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import Moya
import Foundation

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    func fetchSearch(query: String, completion: @escaping (Swift.Result<BaseResponse<[ResultResponse]>, Error>) -> ())
}

class NetworkManager: Networkable {
    func fetchSearch(query: String, completion: @escaping (Result<BaseResponse<[ResultResponse]>, Error>) -> ()) {
        request(target: .search(query: query), completion: completion)
    }
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
}

private extension NetworkManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Swift.Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

