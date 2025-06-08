//
//  GithubUser.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

struct GitHubUser: Identifiable, Hashable {
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
