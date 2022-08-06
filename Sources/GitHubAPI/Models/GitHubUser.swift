//
//  GitHubUser.swift
//
//
//  Created by Kamaal M Farah on 27/03/2022.
//

import Foundation

public struct GitHubUser: Codable, Hashable, Identifiable {
    public let id: Int
    public let login: String
    public let avatarURL: URL
    public let url: URL

    public init(id: Int, login: String, avatarURL: URL, url: URL) {
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
        self.url = url
    }

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case url
    }
}
