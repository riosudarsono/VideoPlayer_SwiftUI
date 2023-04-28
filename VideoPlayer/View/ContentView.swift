//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @ObservedObject var mainVM: VideoPlayerVM
    @State private var player : AVPlayer?
    @StateObject var viewModel = ContentVM()
    @State var loading = false
    @State var resultVideo: [ResultResponse] = []
    @State var dataVideo: ResultResponse? = nil
    
    @Environment(\.horizontalSizeClass) var wSizeClass
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                logic
                if loading {
                    ProgressView()
                }
                VStack(spacing: 0) {
                    if dataVideo != nil {
                        videoView
                    }
                    ScrollView {
                        VStack(spacing: 0) {
                            
                            ForEach(resultVideo, id: \.trackId) {item in
                                Button {
                                    dataVideo = item
                                    videoPlay()
                                } label: {
                                    cell(data: item)
                                }
                                .background(item.trackId == dataVideo?.trackId ? Color.black.opacity(0.1) : Color.clear)
                                Divider()
                            }
                        }
                    }
                }
                .onAppear {
                    AppDelegate.orientation = UIInterfaceOrientationMask.portrait
                    self.mainVM.setNeedsUpdateOfSupportedInterfaceOrientations()
                    viewModel.fetchSearch(query: "jack+johnson")
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var videoView: some View {
        ZStack(alignment: .topLeading) {
            VideoPlayer(player: player)
                .frame(width: UIScreen.main.bounds.width, height: 200 )
            Image(systemName: "viewfinder")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.orange)
                .padding()
                .onTapGesture {
                    mainVM.dataVideo = self.dataVideo
                    mainVM.path.append(VideoFullView.path)
                    player?.pause()
                }
        }
    }
    
    func videoPlay() {
        self.player?.pause()
        guard let url = URL(string: dataVideo?.previewUrl ?? "") else {
            return
        }
        let player = AVPlayer(url: url)
        self.player = player
        self.player?.play()
    }
    
    private func cell(data: ResultResponse) -> some View {
        HStack(spacing: 0) {
            Image(systemName: "play.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(.orange)
                .padding(.trailing, 16)
            VStack(alignment: .leading, spacing: 0) {
                Text(data.trackCensoredName ?? "")
                    .bold()
                    .lineLimit(2)
                    .padding(.bottom, 8)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Text(data.kind ?? "")
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
    
    var logic: some View {
        ZStack {
            switch viewModel.resultSearch {
            case .loading:
                Text("").onAppear {
                    loading = true
                }
            case .failed(_):
                Text("")
            case .success(let data):
                Text("").onAppear {
                    loading = false
                    resultVideo = data ?? []
                }
            case .expired(_):
                Text("")
            case ._init:
                Text("")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mainVM: VideoPlayerVM())
    }
}
