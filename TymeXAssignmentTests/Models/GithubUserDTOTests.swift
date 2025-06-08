import XCTest
@testable import TymeXAssignment

final class GithubUserDTOTests: XCTestCase {
    func testGitHubUserDTO_ToEntity_ShouldMapCorrectly() {
        let dto = GitHubUserDTO.mock()
        let entity = dto.toDomain()
        
        XCTAssertEqual(entity.login, "mojombo")
        XCTAssertEqual(entity.id, 1)
        XCTAssertEqual(entity.nodeId, "MDQ6VXNlcjE=")
        XCTAssertEqual(entity.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertNil(entity.gravatarId)
        XCTAssertEqual(entity.url, "https://api.github.com/users/mojombo")
        XCTAssertEqual(entity.htmlUrl, "https://github.com/mojombo")
        XCTAssertEqual(entity.followersUrl, "https://api.github.com/users/mojombo/followers")
        XCTAssertEqual(entity.followingUrl, "https://api.github.com/users/mojombo/following{/other_user}")
        XCTAssertEqual(entity.gistsUrl, "https://api.github.com/users/mojombo/gists{/gist_id}")
        XCTAssertEqual(entity.starredUrl, "https://api.github.com/users/mojombo/starred{/owner}{/repo}")
        XCTAssertEqual(entity.subscriptionsUrl, "https://api.github.com/users/mojombo/subscriptions")
        XCTAssertEqual(entity.organizationsUrl, "https://api.github.com/users/mojombo/orgs")
        XCTAssertEqual(entity.reposUrl, "https://api.github.com/users/mojombo/repos")
        XCTAssertEqual(entity.eventsUrl, "https://api.github.com/users/mojombo/events{/privacy}")
        XCTAssertEqual(entity.receivedEventsUrl, "https://api.github.com/users/mojombo/received_events")
        XCTAssertEqual(entity.type, "User")
        XCTAssertEqual(entity.userViewType, "public")
        XCTAssertEqual(entity.siteAdmin, false)
    }
    
    func testGitHubUserDTO_Decoding_WithValidJSON() throws {
        let json = """
        {
            "login": "mojombo",
            "id": 1,
            "node_id": "MDQ6VXNlcjE=",
            "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
            "url": "https://api.github.com/users/mojombo",
            "html_url": "https://github.com/mojombo",
            "type": "User",
            "site_admin": false
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let dto = try JSONDecoder().decode(GitHubUserDTO.self, from: jsonData)
        
        XCTAssertEqual(dto.login?.value, "mojombo")
        XCTAssertEqual(dto.id?.value, 1)
        XCTAssertEqual(dto.nodeId?.value, "MDQ6VXNlcjE=")
        XCTAssertEqual(dto.avatarUrl?.value, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(dto.url?.value, "https://api.github.com/users/mojombo")
        XCTAssertEqual(dto.htmlUrl?.value, "https://github.com/mojombo")
        XCTAssertEqual(dto.type?.value, "User")
        XCTAssertEqual(dto.siteAdmin?.value, false)
    }
}
