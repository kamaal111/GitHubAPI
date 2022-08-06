//
//  GitHubAPISpec.swift
//
//
//  Created by Kamaal M Farah on 27/03/2022.
//

import Quick
import Nimble
@testable import GitHubAPI
import Foundation
import MockURLProtocol

final class GitHubAPISpec: QuickSpec {
    override func spec() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let githubAPI = GitHubAPI(token: "some token", username: "kamaal111", urlSession: urlSession)

        describe("defaultHeaders") {
            it("creates default headers with encoded user") {
                let headers = githubAPI.repos.defaultHeaders
                expect(headers.count) == 2
                expect(headers["Authorization"]) == "Basic a2FtYWFsMTExOnNvbWUgdG9rZW4="
                expect(headers["accept"]) == "application/vnd.github.v3+json"
            }
        }

        describe("createIssue") {
            let username = "kamaal111"
            let repoName = "GitHubAPI"
            let apiURL = BaseGitHubAPIClient.BASE_URL
                .appendingPathComponent("repos")
                .appendingPathComponent(username)
                .appendingPathComponent(repoName)
                .appendingPathComponent("issues")

            it("creates issue") {
                MockURLProtocol.requestHandler = { _ in
                    let response = HTTPURLResponse(
                        url: apiURL,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil
                    )!

                    let data = issueResponse.data(using: .utf8)
                    return (response, data)
                }

                let expectation = self.expectation(description: "Expectation")
                Task {
                    let result = await githubAPI.repos.createIssue(
                        username: username,
                        repoName: repoName,
                        title: "Testing",
                        description: "Something to test",
                        assignee: "kamaal111",
                        labels: ["Test"]
                    )
                    let issue = try result.get()
                    expect(issue.id) == 1_182_606_460
                    expect(issue.url) == URL(string: "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5")

                    expectation.fulfill()
                }
                self.wait(for: [expectation], timeout: 2)
            }

            it("fails to create a issue") {
                let statusCode = 400
                let jsonString = """
                {
                    "message": "oh nooooo!"
                }
                """

                MockURLProtocol.requestHandler = { _ in
                    let response = HTTPURLResponse(
                        url: apiURL,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil
                    )!

                    let data = jsonString.data(using: .utf8)
                    return (response, data)
                }

                let expectation = self.expectation(description: "Expectation")
                Task {
                    let result = await githubAPI.repos.createIssue(
                        username: username,
                        repoName: repoName,
                        title: "Testing"
                    )
                    expect { try result.get() }.to(throwError { error in
                        let castedError = error as! BaseGitHubAPIClient.Errors
                        expect(castedError) == .responseError(message: jsonString, code: 400)
                        expectation.fulfill()
                    })
                }
                self.wait(for: [expectation], timeout: 1)
            }
        }
    }
}

let issueResponse = """
{
  "url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5",
  "repository_url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay",
  "labels_url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5/labels{/name}",
  "comments_url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5/comments",
  "events_url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5/events",
  "html_url": "https://github.com/kamaal111/GitHubAPIPlay/issues/5",
  "id": 1182606460,
  "node_id": "I_kwDOHEYY085GfSR8",
  "number": 5,
  "title": "Test2",
  "user": {
    "login": "kamaal111",
    "id": 37084924,
    "node_id": "MDQ6VXNlcjM3MDg0OTI0",
    "avatar_url": "https://avatars.githubusercontent.com/u/37084924?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/kamaal111",
    "html_url": "https://github.com/kamaal111",
    "followers_url": "https://api.github.com/users/kamaal111/followers",
    "following_url": "https://api.github.com/users/kamaal111/following{/other_user}",
    "gists_url": "https://api.github.com/users/kamaal111/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/kamaal111/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/kamaal111/subscriptions",
    "organizations_url": "https://api.github.com/users/kamaal111/orgs",
    "repos_url": "https://api.github.com/users/kamaal111/repos",
    "events_url": "https://api.github.com/users/kamaal111/events{/privacy}",
    "received_events_url": "https://api.github.com/users/kamaal111/received_events",
    "type": "User",
    "site_admin": false
  },
  "labels": [
    {
      "id": 3970057341,
      "node_id": "LA_kwDOHEYY087sokR9",
      "url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/labels/New",
      "name": "New",
      "color": "bfdadc",
      "default": false,
      "description": ""
    }
  ],
  "state": "open",
  "locked": false,
  "assignee": {
    "login": "kamaal111",
    "id": 37084924,
    "node_id": "MDQ6VXNlcjM3MDg0OTI0",
    "avatar_url": "https://avatars.githubusercontent.com/u/37084924?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/kamaal111",
    "html_url": "https://github.com/kamaal111",
    "followers_url": "https://api.github.com/users/kamaal111/followers",
    "following_url": "https://api.github.com/users/kamaal111/following{/other_user}",
    "gists_url": "https://api.github.com/users/kamaal111/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/kamaal111/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/kamaal111/subscriptions",
    "organizations_url": "https://api.github.com/users/kamaal111/orgs",
    "repos_url": "https://api.github.com/users/kamaal111/repos",
    "events_url": "https://api.github.com/users/kamaal111/events{/privacy}",
    "received_events_url": "https://api.github.com/users/kamaal111/received_events",
    "type": "User",
    "site_admin": false
  },
  "assignees": [
    {
      "login": "kamaal111",
      "id": 37084924,
      "node_id": "MDQ6VXNlcjM3MDg0OTI0",
      "avatar_url": "https://avatars.githubusercontent.com/u/37084924?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/kamaal111",
      "html_url": "https://github.com/kamaal111",
      "followers_url": "https://api.github.com/users/kamaal111/followers",
      "following_url": "https://api.github.com/users/kamaal111/following{/other_user}",
      "gists_url": "https://api.github.com/users/kamaal111/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/kamaal111/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/kamaal111/subscriptions",
      "organizations_url": "https://api.github.com/users/kamaal111/orgs",
      "repos_url": "https://api.github.com/users/kamaal111/repos",
      "events_url": "https://api.github.com/users/kamaal111/events{/privacy}",
      "received_events_url": "https://api.github.com/users/kamaal111/received_events",
      "type": "User",
      "site_admin": false
    }
  ],
  "milestone": null,
  "comments": 0,
  "created_at": "2022-03-27T17:39:47Z",
  "updated_at": "2022-03-27T17:39:47Z",
  "closed_at": null,
  "author_association": "OWNER",
  "active_lock_reason": null,
  "body": "Testing",
  "closed_by": null,
  "reactions": {
    "url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5/reactions",
    "total_count": 0,
    "+1": 0,
    "-1": 0,
    "laugh": 0,
    "hooray": 0,
    "confused": 0,
    "heart": 0,
    "rocket": 0,
    "eyes": 0
  },
  "timeline_url": "https://api.github.com/repos/kamaal111/GitHubAPIPlay/issues/5/timeline",
  "performed_via_github_app": null
}
"""
