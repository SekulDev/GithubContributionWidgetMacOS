//
//  ContributionViews.swift
//  GithubContributionWidgetMacOS
//
//  Created by Sekul on 27.09.2025.
//

import SwiftUI
import WidgetKit

struct ContributionCell: View {
    let contribution: ContributionDay
    let size: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: size * 0.2)
            .fill(contribution.intensity.color)
            .frame(width: size, height: size)
    }
}

struct ContributionGrid: View {
    let contributions: [ContributionDay]
    let family: WidgetFamily

    private var spacing: CGFloat { 3.0 }

    var body: some View {
        GeometryReader { geometry in
            let verticalPadding = geometry.size.height * 0.08
            let horizontalPadding = verticalPadding

            let availableHeight = geometry.size.height - (verticalPadding * 2)
            let availableWidth = geometry.size.width - (horizontalPadding * 2)

            let totalSpacing = spacing * 6
            let cellSize = (availableHeight - totalSpacing) / 7
            let weekWidth = cellSize + spacing
            let maxWeeks = Int(availableWidth / weekWidth)
            let weeksToShow = min(maxWeeks, 52)

            let calendar = Calendar.current
            let today = contributions.last?.date ?? Date()
            let weekday = calendar.component(.weekday, from: today)
            let totalDaysNeeded = (weeksToShow * 7) + weekday

            let contributionsToShow = Array(
                contributions.suffix(totalDaysNeeded)
            )
            let weeksArray = weeks(from: contributionsToShow)

            let actualGridWidth =
                CGFloat(weeksArray.count) * cellSize + CGFloat(
                    weeksArray.count - 1
                ) * spacing

            HStack(spacing: spacing) {
                ForEach(weeksArray.indices, id: \.self) { weekIndex in
                    VStack(spacing: spacing) {
                        ForEach(0..<7) { dayIndex in
                            ContributionCell(
                                contribution: weeksArray[weekIndex][dayIndex],
                                size: cellSize
                            )
                        }
                    }
                }
            }
            .frame(width: actualGridWidth, height: availableHeight)
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center
            )
        }
    }

    private func weeks(from contributions: [ContributionDay])
        -> [[ContributionDay]]
    {
        guard !contributions.isEmpty else { return [] }

        var weeks: [[ContributionDay]] = []
        var currentWeek: [ContributionDay] = []

        for day in contributions {
            currentWeek.append(day)
            if currentWeek.count == 7 {
                weeks.append(currentWeek)
                currentWeek = []
            }
        }

        if !currentWeek.isEmpty {
            
            while currentWeek.count < 7 {
                currentWeek.append(
                    ContributionDay(date: Date(), contributionCount: nil)
                )
            }
            weeks.append(currentWeek)
        }

        return weeks
    }
}
