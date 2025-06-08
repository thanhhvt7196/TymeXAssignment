//
//  GitHubUserDTO.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation

struct GitHubUserDTO: Codable {
    let login: DataType<String>?
    let id: DataType<Int>?
    let nodeId: DataType<String>?
    let avatarUrl: DataType<String>?
    let gravatarId: DataType<String>?
    let url: DataType<String>?
    let htmlUrl: DataType<String>?
    let followersUrl: DataType<String>?
    let followingUrl: DataType<String>?
    let gistsUrl: DataType<String>?
    let starredUrl: DataType<String>?
    let subscriptionsUrl: DataType<String>?
    let organizationsUrl: DataType<String>?
    let reposUrl: DataType<String>?
    let eventsUrl: DataType<String>?
    let receivedEventsUrl: DataType<String>?
    let type: DataType<String>?
    let userViewType: DataType<String>?
    let siteAdmin: DataType<Bool>?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}

extension GitHubUserDTO: DomainConvertible {
    func toDomain() -> GitHubUser {
        return GitHubUser(login: login?.value,
                          id: id?.value ?? -1,
                          nodeId: nodeId?.value,
                          avatarUrl: avatarUrl?.value,
                          gravatarId: gravatarId?.value,
                          url: url?.value,
                          htmlUrl: htmlUrl?.value,
                          followersUrl: followersUrl?.value,
                          followingUrl: followingUrl?.value,
                          gistsUrl: gistsUrl?.value,
                          starredUrl: starredUrl?.value,
                          subscriptionsUrl: subscriptionsUrl?.value,
                          organizationsUrl: organizationsUrl?.value,
                          reposUrl: reposUrl?.value,
                          eventsUrl: eventsUrl?.value,
                          receivedEventsUrl: receivedEventsUrl?.value,
                          type: type?.value,
                          userViewType: userViewType?.value,
                          siteAdmin: siteAdmin?.value)
    }
}
