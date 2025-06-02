//
//  GithubUserSwiftData.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftData

@Model
final class GithubUserSwiftData {
    @Attribute(.unique)
    var login: String?
    var id: Int
    var nodeId: String?
    var avatarUrl: String?
    var gravatarId: String?
    var url: String?
    var htmlUrl: String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var reposUrl: String?
    var eventsUrl: String?
    var receivedEventsUrl: String?
    var type: String?
    var userViewType: String?
    var siteAdmin: Bool?
    
    init(login: String?, id: Int, nodeId: String? = nil, avatarUrl: String? = nil, gravatarId: String? = nil, url: String? = nil, htmlUrl: String? = nil, followersUrl: String? = nil, followingUrl: String? = nil, gistsUrl: String? = nil, starredUrl: String? = nil, subscriptionsUrl: String? = nil, organizationsUrl: String? = nil, reposUrl: String? = nil, eventsUrl: String? = nil, receivedEventsUrl: String? = nil, type: String? = nil, userViewType: String? = nil, siteAdmin: Bool? = nil) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.avatarUrl = avatarUrl
        self.gravatarId = gravatarId
        self.url = url
        self.htmlUrl = htmlUrl
        self.followersUrl = followersUrl
        self.followingUrl = followingUrl
        self.gistsUrl = gistsUrl
        self.starredUrl = starredUrl
        self.subscriptionsUrl = subscriptionsUrl
        self.organizationsUrl = organizationsUrl
        self.reposUrl = reposUrl
        self.eventsUrl = eventsUrl
        self.receivedEventsUrl = receivedEventsUrl
        self.type = type
        self.userViewType = userViewType
        self.siteAdmin = siteAdmin
    }
}

extension GithubUserSwiftData: DomainConvertible {
    func toDomain() -> GitHubUser {
        return GitHubUser(
            login: login, id: id, nodeId: nodeId,
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
