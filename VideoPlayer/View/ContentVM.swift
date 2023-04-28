//
//  ContentVM.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import Foundation
import UIKit

class ContentVM: ObservableObject {
    @Published var resultSearch: ResultState<[ResultResponse]> = ._init
    
    private let networkManager = NetworkManager()
    
    func fetchSearch(query: String){
        self.resultSearch = .loading
        networkManager.fetchSearch(query: query) { [weak self] result in
            switch result{
            case .success(let response):
                self?.resultSearch = .success(data: response.results)
                break
            case .failure(let error):
                print(error)
                self?.resultSearch = .failed(error: error.localizedDescription)
                break
            }
        }
    }
    
}
