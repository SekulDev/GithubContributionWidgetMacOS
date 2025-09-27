//
//  GithubAPI.swift
//  GithubContributionWidgetMacOS
//
//  Created by Sekul on 27.09.2025.
//

import Foundation

struct GitHubAPI {
    static let endpoint = URL(string: "https://api.github.com/graphql")!
    
    static func fetchContributions(username: String, token: String?) async throws -> [ContributionDay] {
        guard !username.isEmpty else { return [] }

        let query = """
        {
          user(login: "\(username)") {
            contributionsCollection {
              contributionCalendar {
                weeks {
                  contributionDays {
                    date
                    contributionCount
                  }
                }
              }
            }
          }
        }
        """
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["query": query]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(GraphQLResponse.self, from: data)
        let weeks = decoded.data.user.contributionsCollection.contributionCalendar.weeks
        let days = weeks.flatMap { $0.contributionDays }
        
        let formatter: DateFormatter = {
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd"
            f.locale = Locale(identifier: "en_US_POSIX")
            return f
        }()
        
        return days.compactMap {
            guard let date = formatter.date(from: $0.date) else { return nil }
            return ContributionDay(date: date, contributionCount: $0.contributionCount)
        }
    }
}

struct GraphQLResponse: Codable {
    let data: GitHubData
}

struct GitHubData: Codable {
    let user: GitHubUser
}

struct GitHubUser: Codable {
    let contributionsCollection: ContributionsCollection
}

struct ContributionsCollection: Codable {
    let contributionCalendar: ContributionCalendar
}

struct ContributionCalendar: Codable {
    let weeks: [Week]
}

struct Week: Codable {
    let contributionDays: [ContributionDayData]
}

struct ContributionDayData: Codable {
    let date: String
    let contributionCount: Int
}
