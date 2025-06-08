//
//  GithubUserDetailDTOTests.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import XCTest
@testable import TymeXAssignment

final class GithubUserDetailDTOTests: XCTestCase {
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
