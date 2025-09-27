//
//  AppIntent.swift
//  GithubContributionWidget
//
//  Created by Sekul on 27.09.2025.
//

import AppIntents
import Foundation
import WidgetKit

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Configure your GitHub widget")

    @Parameter(title: "GitHub Username", default: "")
    var username: String

    @Parameter(title: "Personal Access Token", default: "")
    var token: String
}
