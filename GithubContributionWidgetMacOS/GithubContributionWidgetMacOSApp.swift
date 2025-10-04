//
//  GithubContributionWidgetMacOSApp.swift
//  GithubContributionWidgetMacOS
//
//  Created by Sekul on 27.09.2025.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true  // Closing app after close last window
    }
}

@main
struct GithubContributionWidgetMacOSApp: App {

    @Environment(\.openURL) var openURL
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                if let url = URL(string: url.absoluteString) {
                    NSWorkspace.shared.open(url)
                }
            }
        }
    }
}
