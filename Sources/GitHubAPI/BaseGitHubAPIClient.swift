//
//  BaseGitHubAPIClient.swift
//
//
//  Created by Kamaal M Farah on 03/04/2022.
//

import Foundation
import XiphiasNet

/// Base case to inherit for other GitHub clients
public class BaseGitHubAPIClient {
    /// Access token
    public let token: String
    /// Username of the access ``GitHubAPI/GitHubAPI/token``
    public let username: String

    let networker: XiphiasNet

    static let BASE_URL = URL(string: "https://api.github.com")!

    /// Initialize ``GitHubAPI/GitHubAPI``
    /// - Parameters:
    ///   - token: access token.
    ///   - username: username of the access ``GitHubAPI/GitHubAPI/token``.
    ///   - urlSession: for testing porpuses.
    public init(token: String, username: String, urlSession: URLSession) {
        self.token = token
        self.username = username
        self.networker = .init(urlSession: urlSession)
    }

    /// Initialize ``GitHubAPI/GitHubAPI``
    /// - Parameters:
    ///   - token: access token.
    ///   - username: username of the access ``GitHubAPI/GitHubAPI/token``.
    public convenience init(token: String, username: String) {
        self.init(token: token, username: username, urlSession: .shared)
    }

    public enum Errors: Error, Equatable {
        case generalError(error: Error)
        case responseError(message: String, code: Int)
        case notAValidJSON
        case parsingError(error: Error)
        case invalidURL(url: String)

        public static func == (lhs: Errors, rhs: Errors) -> Bool {
            lhs.identifier == rhs.identifier
        }

        private var identifier: String {
            switch self {
            case let .generalError(error: error): return "general_error_\(error.localizedDescription)"
            case let .responseError(message, code): return "response_error_\(message)_\(code)"
            case .notAValidJSON: return "not_a_valid_json"
            case let .parsingError(error: error): return "parsing_error_\(error.localizedDescription)"
            case let .invalidURL(url: url): return "invalid_url_\(url)"
            }
        }
    }

    var defaultHeaders: [String: String] {
        var headers = [
            "accept": "application/vnd.github.v3+json",
        ]

        if let login = "\(username):\(token)".data(using: .utf8) {
            headers["Authorization"] = "Basic \(login.base64EncodedString())"
        }

        return headers
    }

    func mapXiphiasNetError(_ xiphiasNetError: XiphiasNet.Errors) -> Errors {
        switch xiphiasNetError {
        case let .generalError(error: error): return .generalError(error: error)
        case let .responseError(message, code): return .responseError(message: message, code: code)
        case .notAValidJSON: return .notAValidJSON
        case let .parsingError(error: error): return .parsingError(error: error)
        case let .invalidURL(url: url): return .invalidURL(url: url)
        }
    }
}
