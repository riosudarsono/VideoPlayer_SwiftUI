//
//  ResultState.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import Foundation

enum ResultState<T> {
    case _init
    case loading
    case success(data: T?)
    case expired(error: String)
    case failed(error: String)
}
