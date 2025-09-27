//
//  GithubContributionWidgetMacOSApp.swift
//  GithubContributionWidgetMacOS
//
//  Created by Sekul on 27.09.2025.
//

import SwiftUI

@main
struct GithubContributionWidgetMacOSApp: App {

    @Environment(\.openURL) var openURL

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
