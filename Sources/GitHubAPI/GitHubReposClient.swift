//
//  GitHubReposClient.swift
//
//
//  Created by Kamaal M Farah on 03/04/2022.
//

import Foundation
import XiphiasNet

public final class GitHubReposClient: BaseGitHubAPIClient {
    /// Create issues on a specific repo.
    /// - Parameters:
    ///   - username: the owner of the repo.
    ///   - repoName: name of repo where to create a issue on.
    ///   - title: title of the issue.
    ///   - description: description of the issue.
    ///   - assignee: username of the assignee on the issue.
    ///   - labels: labels on the issue.
    /// - Returns: the created issue if issue creation succeeds or returns a error.
    public func createIssue(
        username: String,
        repoName: String,
        title: String,
        description: String? = nil,
        assignee: String? = nil,
        labels: [String]? = nil
    ) async -> Result<GitHubIssue, Errors> {
        let url = Self.BASE_URL
            .appendingPathComponent("repos")
            .appendingPathComponent(username)
            .appendingPathComponent(repoName)
            .appendingPathComponent("issues")
        var payload: [String: Any] = [
            "title": title,
        ]
        if let description = description {
            payload["body"] = description
        }
        if let assignee = assignee {
            payload["assignee"] = assignee
        }
        if let labels = labels {
            payload["labels"] = labels
        }
        let config = XRequestConfig(priority: XRequestConfig.defaultPriority, kowalskiAnalysis: false)
        let result: Result<Response<GitHubIssue>, XiphiasNet.Errors> = await networker.request(
            from: url,
            method: .post,
            payload: payload,
            headers: defaultHeaders,
            config: config
        )

        return result
            .map(\.data)
            .mapError(mapXiphiasNetError(_:))
    }
}
