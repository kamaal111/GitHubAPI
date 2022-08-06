//
//  GitHubIssue.swift
//
//
//  Created by Kamaal M Farah on 27/03/2022.
//

import Foundation

public struct GitHubIssue: Codable, Hashable, Identifiable {
    public let id: Int
    public let url: URL
    public let repositoryURL: URL
    public let number: Int
    public let title: String
    public let user: GitHubUser
    public let labels: [GitHubIssueLabel]
    public let rawState: String
    public let locked: Bool
    public let assignee: GitHubUser?
    public let assignees: [GitHubUser]
    public let comments: Int
    public let createdAt: String
    public let updatedAt: String
    public let closedAt: String?
    public let rawAuthorAssociation: String
    public let body: String?
    public let reactions: GitHubIssueReactions

    public init(
        id: Int,
        url: URL,
        repositoryURL: URL,
        number: Int,
        title: String,
        user: GitHubUser,
        labels: [GitHubIssueLabel],
        rawState: String,
        locked: Bool,
        assignee: GitHubUser?,
        assignees: [GitHubUser],
        comments: Int,
        createdAt: String,
        updatedAt: String,
        closedAt: String?,
        rawAuthorAssociation: String,
        body: String?,
        reactions: GitHubIssueReactions
    ) {
        self.id = id
        self.url = url
        self.repositoryURL = repositoryURL
        self.number = number
        self.title = title
        self.user = user
        self.labels = labels
        self.rawState = rawState
        self.locked = locked
        self.assignee = assignee
        self.assignees = assignees
        self.comments = comments
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.closedAt = closedAt
        self.rawAuthorAssociation = rawAuthorAssociation
        self.body = body
        self.reactions = reactions
    }

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case repositoryURL = "repository_url"
        case number
        case title
        case user
        case labels
        case rawState = "state"
        case locked
        case assignee
        case assignees
        case comments
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case rawAuthorAssociation = "author_association"
        case body
        case reactions
    }

    public enum States: String {
        case open
    }

    public enum AuthorAssociations: String {
        case owner = "OWNER"
        case collaborator = "COLLABORATOR"
    }

    public var state: States? {
        States(rawValue: rawState)
    }

    public var authorAssociation: AuthorAssociations? {
        AuthorAssociations(rawValue: rawAuthorAssociation)
    }
}
