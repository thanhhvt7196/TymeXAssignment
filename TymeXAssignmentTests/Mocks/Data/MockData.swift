import Foundation
@testable import TymeXAssignment

extension APIError {
    static func mock() -> APIError {
        return APIError(message: "Mock API Error")
    }
}

extension GitHubUserDTO {
    static func mock() -> GitHubUserDTO {
        return GitHubUserDTO(
            login: .value("mojombo"),
            id: .value(1),
            nodeId: .value("MDQ6VXNlcjE="),
            avatarUrl: .value("https://avatars.githubusercontent.com/u/1?v=4"),
            gravatarId: nil,
            url: .value("https://api.github.com/users/mojombo"),
            htmlUrl: .value("https://github.com/mojombo"),
            followersUrl: .value("https://api.github.com/users/mojombo/followers"),
            followingUrl: .value("https://api.github.com/users/mojombo/following{/other_user}"),
            gistsUrl: .value("https://api.github.com/users/mojombo/gists{/gist_id}"),
            starredUrl: .value("https://api.github.com/users/mojombo/starred{/owner}{/repo}"),
            subscriptionsUrl: .value("https://api.github.com/users/mojombo/subscriptions"),
            organizationsUrl: .value("https://api.github.com/users/mojombo/orgs"),
            reposUrl: .value("https://api.github.com/users/mojombo/repos"),
            eventsUrl: .value("https://api.github.com/users/mojombo/events{/privacy}"),
            receivedEventsUrl: .value("https://api.github.com/users/mojombo/received_events"),
            type: .value("User"),
            userViewType: .value("public"),
            siteAdmin: .value(false)
        )
    }
}

extension GithubUserDetailDTO {
    static func mock() -> GithubUserDetailDTO {
        return GithubUserDetailDTO(
            id: .value(1),
            login: .value("mojombo"),
            nodeId: .value("MDQ6VXNlcjE="),
            avatarUrl: .value("https://avatars.githubusercontent.com/u/1?v=4"),
            gravatarId: nil,
            url: .value("https://api.github.com/users/mojombo"),
            htmlUrl: .value("https://github.com/mojombo"),
            followersUrl: .value("https://api.github.com/users/mojombo/followers"),
            followingUrl: .value("https://api.github.com/users/mojombo/following{/other_user}"),
            gistsUrl: .value("https://api.github.com/users/mojombo/gists{/gist_id}"),
            starredUrl: .value("https://api.github.com/users/mojombo/starred{/owner}{/repo}"),
            subscriptionsUrl: .value("https://api.github.com/users/mojombo/subscriptions"),
            organizationsUrl: .value("https://api.github.com/users/mojombo/orgs"),
            reposUrl: .value("https://api.github.com/users/mojombo/repos"),
            eventsUrl: .value("https://api.github.com/users/mojombo/events{/privacy}"),
            receivedEventsUrl: .value("https://api.github.com/users/mojombo/received_events"),
            type: .value("User"),
            userViewType: .value("public"),
            siteAdmin: .value(false),
            name: .value("Tom Preston-Werner"),
            company: .value("@chatterbugapp, @redwoodjs, @preston-werner-ventures"),
            blog: .value("http://tom.preston-werner.com"),
            location: .value("San Francisco"),
            email: nil,
            hireable: nil,
            bio: nil,
            twitterUsername: .value("mojombo"),
            publicRepos: .value(64),
            publicGists: .value(62),
            followers: .value(23697),
            following: .value(11),
            createdAt: .value("2007-10-20T05:24:19Z"),
            updatedAt: .value("2024-02-21T20:39:41Z")
        )
    }
} 
