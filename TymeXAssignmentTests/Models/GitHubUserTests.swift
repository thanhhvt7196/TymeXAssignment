import XCTest
@testable import TymeXAssignment

final class GitHubUserTests: XCTestCase {
    func testGitHubUserDecoding() throws {
        // Given
        let json = """
        {
            "login": "octocat",
            "id": 1,
            "node_id": "MDQ6VXNlcjE=",
            "avatar_url": "https://github.com/images/error/octocat_happy.gif",
            "html_url": "https://github.com/octocat",
            "type": "User",
            "site_admin": false
        }
        """.data(using: .utf8)!
        
        // When
        let user = try JSONDecoder().decode(GitHubUser.self, from: json)
        
        // Then
        XCTAssertEqual(user.login, "octocat")
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.nodeId, "MDQ6VXNlcjE=")
        XCTAssertEqual(user.avatarUrl, "https://github.com/images/error/octocat_happy.gif")
        XCTAssertEqual(user.htmlUrl, "https://github.com/octocat")
        XCTAssertEqual(user.type, "User")
        XCTAssertEqual(user.siteAdmin, false)
    }
    
    func testGitHubUserSwiftDataConversion() {
        // Given
        let user = GitHubUser(
            login: "octocat",
            id: 1,
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://github.com/images/error/octocat_happy.gif",
            gravatarId: nil,
            url: nil,
            htmlUrl: "https://github.com/octocat",
            followersUrl: nil,
            followingUrl: nil,
            gistsUrl: nil,
            starredUrl: nil,
            subscriptionsUrl: nil,
            organizationsUrl: nil,
            reposUrl: nil,
            eventsUrl: nil,
            receivedEventsUrl: nil,
            type: "User",
            userViewType: nil,
            siteAdmin: false
        )
        
        // When
        let swiftDataUser = user.toSwiftData()
        let reconvertedUser = swiftDataUser.toDomain()
        
        // Then
        XCTAssertEqual(user.login, reconvertedUser.login)
        XCTAssertEqual(user.id, reconvertedUser.id)
        XCTAssertEqual(user.nodeId, reconvertedUser.nodeId)
        XCTAssertEqual(user.avatarUrl, reconvertedUser.avatarUrl)
        XCTAssertEqual(user.htmlUrl, reconvertedUser.htmlUrl)
        XCTAssertEqual(user.type, reconvertedUser.type)
        XCTAssertEqual(user.siteAdmin, reconvertedUser.siteAdmin)
    }
} 