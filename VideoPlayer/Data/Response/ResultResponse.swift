//
//  ResultResponse.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import Foundation

struct ResultResponse: Codable {
    let trackId: Int?
    let trackCensoredName: String?
    let kind: String?
    let previewUrl: String?
}
