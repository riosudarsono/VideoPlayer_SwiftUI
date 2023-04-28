//
//  VideoPlayerVM.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 28/04/23.
//

import SwiftUI

class VideoPlayerVM: UINavigationController, ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var dataVideo: ResultResponse? = nil
}
