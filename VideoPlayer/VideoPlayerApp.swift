//
//  VideoPlayerApp.swift
//  VideoPlayer
//
//  Created by Rio Sudarsono on 27/04/23.
//

import SwiftUI

@main
struct VideoPlayerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var viewModel = VideoPlayerVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $viewModel.path) {
                ContentView(mainVM: viewModel)
                    .navigationDestination(for: String.self) { value in
                        onLink(value: value)
                    }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.orange)
        }
    }
    
    private func onLink(value: String) -> some View {
        ZStack {
            if value == VideoFullView.path {
                VideoFullView(mainVM: viewModel)
            }
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientation = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientation
    }
}
