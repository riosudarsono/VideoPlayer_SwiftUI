//
//  VideoFullView.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 28/04/23.
//

import SwiftUI
import AVKit

struct VideoFullView: View {
    @ObservedObject var mainVM: VideoPlayerVM
    public static let path = "VIDEO_FULL"
    @State private var player : AVPlayer?
    
    var body: some View {
        ZStack(alignment: .topLeading){
            VideoPlayer(player: player)
        }
        .onAppear(perform: {
            guard let url = URL(string: mainVM.dataVideo?.previewUrl ?? "") else {
                return
            }
            let player = AVPlayer(url: url)
            self.player = player
            self.player?.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                AppDelegate.orientation = UIInterfaceOrientationMask.landscape
                self.mainVM.setNeedsUpdateOfSupportedInterfaceOrientations()
            }
        }).onDisappear(perform: {
            player?.pause()
        })
        .ignoresSafeArea()
    }
    
}
