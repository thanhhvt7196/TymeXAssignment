//
//  GithubUser.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

struct GitHubUser: Codable, Identifiable, Hashable {
    let login: String?
    let id: Int
    let nodeId: String?
    let avatarUrl: String?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let userViewType: String?
    let siteAdmin: Bool?
    
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

extension GitHubUser: SwiftDataRepresentable {
    func toSwiftData() -> GithubUserSwiftData {
        return GithubUserSwiftData(
            login: login,
            id: id,
            nodeId: nodeId,
            avatarUrl: avatarUrl,
            gravatarId: gravatarId,
            url: url,
            htmlUrl: htmlUrl,
            followersUrl: followersUrl,
            followingUrl: followingUrl,
            gistsUrl: gistsUrl,
            starredUrl: starredUrl,
            subscriptionsUrl: subscriptionsUrl,
            organizationsUrl: organizationsUrl,
            reposUrl: reposUrl,
            eventsUrl: eventsUrl,
            receivedEventsUrl: receivedEventsUrl,
            type: type,
            userViewType: userViewType,
            siteAdmin: siteAdmin
        )
    }
}
