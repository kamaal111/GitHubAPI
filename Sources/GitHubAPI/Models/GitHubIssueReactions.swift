//
//  GitHubIssueReactions.swift
//
//
//  Created by Kamaal M Farah on 27/03/2022.
//

import Foundation

public struct GitHubIssueReactions: Codable, Hashable {
    public let url: URL
    public let totalCount: Int
    public let plus1: Int
    public let minus1: Int
    public let laugh: Int
    public let hooray: Int
    public let confused: Int
    public let heart: Int
    public let rocket: Int
    public let eyes: Int

    public init(
        url: URL,
        totalCount: Int,
        plus1: Int,
        minus1: Int,
        laugh: Int,
        hooray: Int,
        confused: Int,
        heart: Int,
        rocket: Int,
        eyes: Int
    ) {
        self.url = url
        self.totalCount = totalCount
        self.plus1 = plus1
        self.minus1 = minus1
        self.laugh = laugh
        self.hooray = hooray
        self.confused = confused
        self.heart = heart
        self.rocket = rocket
        self.eyes = eyes
    }

    enum CodingKeys: String, CodingKey {
        case url
        case totalCount = "total_count"
        case plus1 = "+1"
        case minus1 = "-1"
        case laugh
        case hooray
        case confused
        case heart
        case rocket
        case eyes
    }
}
