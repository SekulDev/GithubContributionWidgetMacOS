//
//  ContentView.swift
//  GithubContributionWidgetMacOS
//
//  Created by Sekul on 27.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green, .gray],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    Text("GitHub Contribution Widget")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Setup Guide for macOS")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 40)

                // Steps
                VStack(alignment: .leading, spacing: 25) {
                    // Step 1
                    StepCard(
                        number: 1,
                        icon: "key.fill",
                        title: "Generate Personal Access Token",
                        color: .purple,
                        link: "https://github.com/settings/tokens",
                        substeps: [
                            "Visit GitHub Personal Access Tokens",
                            "Click 'Generate new token'",
                            "Select 'Classic' token type",
                            "Choose 'No expiration' for duration",
                            "Check 'user:read' permission",
                            "Click 'Generate token' and copy it securely",
                        ]
                    )

                    // Step 2
                    StepCard(
                        number: 2,
                        icon: "plus.square.fill",
                        title: "Add Widget to Desktop",
                        color: .blue,
                        substeps: [
                            "Right-click on your desktop",
                            "Select 'Edit Widgets' from the menu",
                            "Find 'GithubContributionWidgetMacOS' in the list",
                            "Drag your preferred widget size to the desktop",
                        ]
                    )

                    // Step 3
                    StepCard(
                        number: 3,
                        icon: "gearshape.fill",
                        title: "Configure Your Widget",
                        color: .green,
                        substeps: [
                            "Right-click on the newly added widget",
                            "Enter your GitHub username",
                            "Paste the personal access token you generated",
                            "Click 'Done' to save your settings",
                        ]
                    )
                }

                // Footer
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Text("You're all set! Enjoy tracking your contributions.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: 800)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

struct StepCard: View {
    let number: Int
    let icon: String
    let title: String
    let color: Color
    var link: String? = nil
    let substeps: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(color.gradient)
                        .frame(width: 50, height: 50)

                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Step \(number)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()

                if let link = link {
                    Link(destination: URL(string: link)!) {
                        HStack(spacing: 6) {
                            Image(systemName: "link")
                            Text("Open")
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(color.gradient)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }

            // Substeps
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(substeps.enumerated()), id: \.offset) {
                    index,
                    substep in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(color.opacity(0.2))
                                .frame(width: 24, height: 24)

                            Text("\(index + 1)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(color)
                        }

                        Text(substep)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()
                    }
                }
            }
            .padding(.leading, 8)
        }
        .padding(20)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    ContentView()
        .frame(width: 1000, height: 1100)
}
