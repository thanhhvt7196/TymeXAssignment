import XCTest
@testable import TymeXAssignment

final class DTOTests: XCTestCase {
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
    
    func testGitHubUserDetailDTO_ToEntity_ShouldMapCorrectly() {
        let dto = GithubUserDetailDTO.mock()
        let entity = dto.toDomain()
        
        XCTAssertEqual(entity.id, 1)
        XCTAssertEqual(entity.login, "mojombo")
        XCTAssertEqual(entity.name, "Tom Preston-Werner")
        XCTAssertEqual(entity.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(entity.bio, nil)
        XCTAssertEqual(entity.location, "San Francisco")
        XCTAssertEqual(entity.publicRepos, 64)
        XCTAssertEqual(entity.followers, 23697)
        XCTAssertEqual(entity.following, 11)
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
    
    func testGitHubUserDetailDTO_Decoding_WithValidJSON() throws {
        let json = """
        {
            "login": "mojombo",
            "id": 1,
            "node_id": "MDQ6VXNlcjE=",
            "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
            "name": "Tom Preston-Werner",
            "company": "@chatterbugapp, @redwoodjs, @preston-werner-ventures",
            "location": "San Francisco",
            "public_repos": 64,
            "followers": 23697,
            "following": 11,
            "created_at": "2007-10-20T05:24:19Z",
            "updated_at": "2024-02-21T20:39:41Z"
        }
        """
        let jsonData = json.data(using: .utf8)!
        
        let dto = try JSONDecoder().decode(GithubUserDetailDTO.self, from: jsonData)
        
        XCTAssertEqual(dto.login?.value, "mojombo")
        XCTAssertEqual(dto.id?.value, 1)
        XCTAssertEqual(dto.nodeId?.value, "MDQ6VXNlcjE=")
        XCTAssertEqual(dto.avatarUrl?.value, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(dto.name?.value, "Tom Preston-Werner")
        XCTAssertEqual(dto.company?.value, "@chatterbugapp, @redwoodjs, @preston-werner-ventures")
        XCTAssertEqual(dto.location?.value, "San Francisco")
        XCTAssertEqual(dto.publicRepos?.value, 64)
        XCTAssertEqual(dto.followers?.value, 23697)
        XCTAssertEqual(dto.following?.value, 11)
        XCTAssertEqual(dto.createdAt?.value, "2007-10-20T05:24:19Z")
        XCTAssertEqual(dto.updatedAt?.value, "2024-02-21T20:39:41Z")
    }
} 
