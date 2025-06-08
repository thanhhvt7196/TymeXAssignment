//
//  GithubUserDetailDTO.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation

struct GithubUserDetailDTO: Codable {
    let id: DataType<Int>?
    
    let login: DataType<String>?
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
    
    let name: DataType<String>?
    let company: DataType<String>?
    let blog: DataType<String>?
    let location: DataType<String>?
    let email: DataType<String>?
    let hireable: DataType<Bool>?
    let bio: DataType<String>?
    let twitterUsername: DataType<String>?
    let publicRepos: DataType<Int>?
    let publicGists: DataType<Int>?
    let followers: DataType<Int>?
    let following: DataType<Int>?
    let createdAt: DataType<String>?
    let updatedAt: DataType<String>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
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
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension GithubUserDetailDTO {
    func toEntity() -> GithubUserDetail {
        return GithubUserDetail(id: id?.value ?? -1,
                                login: login?.value,
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
                                siteAdmin: siteAdmin?.value,
                                name: name?.value,
                                company: company?.value,
                                blog: blog?.value,
                                location: location?.value,
                                email: email?.value,
                                hireable: hireable?.value,
                                bio: bio?.value,
                                twitterUsername: twitterUsername?.value,
                                publicRepos: publicRepos?.value,
                                publicGists: publicGists?.value,
                                followers: followers?.value,
                                following: following?.value,
                                createdAtDate: createdAt?.value?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
                                updatedAtDate: updatedAt?.value?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"))
    }
}
