//
//  Models.swift
//  GithubContributionWidgetMacOS
//
//  Created by Sekul on 27.09.2025.
//

import Foundation
import SwiftUI

struct ContributionDay {
    let date: Date
    let contributionCount: Int?

    var intensity: ContributionIntensity {
        switch contributionCount {
        case nil:
            return .transparent
        case let count?:
            switch count {
            case 0: return .none
            case 1...3: return .low
            case 4...6: return .medium
            case 7...10: return .high
            default: return .veryHigh
            }
        }
    }
}

enum ContributionIntensity: Int, Hashable, CaseIterable {
    case transparent = -1
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
    case veryHigh = 4

    var color: Color {
        switch self {
        case .transparent:
            return Color.black.opacity(0)
        case .none:
            return Color(red: 0.16, green: 0.20, blue: 0.24)
        case .low: return Color(hex: "0e4429")
        case .medium: return Color(hex: "006d32")
        case .high: return Color(hex: "26a641")
        case .veryHigh: return Color(hex: "39d353")
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted
        )
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a: UInt64
        let r: UInt64
        let g: UInt64
        let b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (
                255,
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )
        case 6:
            (a, r, g, b) = (
                255,
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        case 8:
            (a, r, g, b) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
