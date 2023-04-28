//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State private var player : AVPlayer?
    @StateObject var viewModel = ContentVM()
    @State var loading = false
    @State var resultVideo: [ResultResponse] = []
    @State var dataVideo: ResultResponse? = nil
    
    var body: some View {
        ZStack {
            logic
            if loading {
                ProgressView()
            }
            ScrollView {
                if dataVideo != nil {
                    videoView
                }
                ForEach(resultVideo, id: \.trackId) {item in
                    Button {
                        dataVideo = item
                        videoPlay()
                    } label: {
                        cell(data: item)
                    }
                    Divider()
                }
            }
            .onAppear {
                viewModel.fetchSearch(query: "jack+johnson")
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var videoView: some View {
        ZStack{
            VideoPlayer(player: player)
                .frame(width: UIScreen.main.bounds.width , height: 200 )
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
        .padding(.vertical, 4)
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
        ContentView()
    }
}
