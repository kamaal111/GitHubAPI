//
//  GitHubIssueLabel.swift
//
//
//  Created by Kamaal M Farah on 27/03/2022.
//

import Foundation

public struct GitHubIssueLabel: Codable, Hashable, Identifiable {
    public let id: Int
    public let url: URL
    public let name: String
    public let description: String
    public let color: String
    public let isDefault: Bool

    public init(id: Int, url: URL, name: String, description: String, color: String, isDefault: Bool) {
        self.id = id
        self.url = url
        self.name = name
        self.description = description
        self.color = color
        self.isDefault = isDefault
    }

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case description
        case color
        case isDefault = "default"
    }
}
