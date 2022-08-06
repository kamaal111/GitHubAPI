//
//  GitHubAPI.swift
//
//
//  Created by Kamaal M Farah on 27/03/2022.
//

import Foundation

/// GitHub API client
public struct GitHubAPI {
    /// Repos client
    public let repos: GitHubReposClient

    /// Initialize ``GitHubAPI/GitHubAPI``
    /// - Parameters:
    ///   - token: access token.
    ///   - username: username of the access ``GitHubAPI/GitHubAPI/token``.
    ///   - urlSession: for testing porpuses.
    public init(token: String, username: String, urlSession: URLSession) {
        self.repos = GitHubReposClient(token: token, username: username, urlSession: urlSession)
    }

    /// Initialize ``GitHubAPI/GitHubAPI``
    /// - Parameters:
    ///   - token: access token.
    ///   - username: username of the access ``GitHubAPI/GitHubAPI/token``.
    public init(token: String, username: String) {
        self.init(token: token, username: username, urlSession: .shared)
    }
}
