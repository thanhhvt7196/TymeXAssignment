import Foundation
@testable import TymeXAssignment

extension APIError {
    static func mock() -> APIError {
        return APIError(message: "Mock API Error")
    }
}

extension GitHubUser {
    static func mock() -> GitHubUser {
        return GitHubUser(
            login: "mojombo",
            id: 1,
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
            gravatarId: nil,
            url: "https://api.github.com/users/mojombo",
            htmlUrl: "https://github.com/mojombo",
            followersUrl: "https://api.github.com/users/mojombo/followers",
            followingUrl: "https://api.github.com/users/mojombo/following{/other_user}",
            gistsUrl: "https://api.github.com/users/mojombo/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/mojombo/subscriptions",
            organizationsUrl: "https://api.github.com/users/mojombo/orgs",
            reposUrl: "https://api.github.com/users/mojombo/repos",
            eventsUrl: "https://api.github.com/users/mojombo/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/mojombo/received_events",
            type: "User",
            userViewType: "public",
            siteAdmin: false
        )
    }
    
    static func mock2() -> GitHubUser {
        return GitHubUser(
            login: "defunkt",
            id: 2,
            nodeId: "MDQ6VXNlcjI=",
            avatarUrl: "https://avatars.githubusercontent.com/u/2?v=4",
            gravatarId: nil,
            url: "https://api.github.com/users/defunkt",
            htmlUrl: "https://github.com/defunkt",
            followersUrl: "https://api.github.com/users/defunkt/followers",
            followingUrl: "https://api.github.com/users/defunkt/following{/other_user}",
            gistsUrl: "https://api.github.com/users/defunkt/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/defunkt/subscriptions",
            organizationsUrl: "https://api.github.com/users/defunkt/orgs",
            reposUrl: "https://api.github.com/users/defunkt/repos",
            eventsUrl: "https://api.github.com/users/defunkt/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/defunkt/received_events",
            type: "User",
            userViewType: "public",
            siteAdmin: false
        )
    }
    
    static func mock3() -> GitHubUser {
        return GitHubUser(
            login: "pjhyett",
            id: 3,
            nodeId: "MDQ6VXNlcjM=",
            avatarUrl: "https://avatars.githubusercontent.com/u/3?v=4",
            gravatarId: nil,
            url: "https://api.github.com/users/pjhyett",
            htmlUrl: "https://github.com/pjhyett",
            followersUrl: "https://api.github.com/users/pjhyett/followers",
            followingUrl: "https://api.github.com/users/pjhyett/following{/other_user}",
            gistsUrl: "https://api.github.com/users/pjhyett/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/pjhyett/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/pjhyett/subscriptions",
            organizationsUrl: "https://api.github.com/users/pjhyett/orgs",
            reposUrl: "https://api.github.com/users/pjhyett/repos",
            eventsUrl: "https://api.github.com/users/pjhyett/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/pjhyett/received_events",
            type: "User",
            userViewType: "public",
            siteAdmin: false
        )
    }
    
    static func mockList() -> [GitHubUser] {
        return [
            GitHubUser(
                login: "mojombo",
                id: 1,
                nodeId: "MDQ6VXNlcjE=",
                avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
                gravatarId: nil,
                url: "https://api.github.com/users/mojombo",
                htmlUrl: "https://github.com/mojombo",
                followersUrl: "https://api.github.com/users/mojombo/followers",
                followingUrl: "https://api.github.com/users/mojombo/following{/other_user}",
                gistsUrl: "https://api.github.com/users/mojombo/gists{/gist_id}",
                starredUrl: "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
                subscriptionsUrl: "https://api.github.com/users/mojombo/subscriptions",
                organizationsUrl: "https://api.github.com/users/mojombo/orgs",
                reposUrl: "https://api.github.com/users/mojombo/repos",
                eventsUrl: "https://api.github.com/users/mojombo/events{/privacy}",
                receivedEventsUrl: "https://api.github.com/users/mojombo/received_events",
                type: "User",
                userViewType: "public",
                siteAdmin: false
            ),
            GitHubUser(
                login: "defunkt",
                id: 2,
                nodeId: "MDQ6VXNlcjI=",
                avatarUrl: "https://avatars.githubusercontent.com/u/2?v=4",
                gravatarId: nil,
                url: "https://api.github.com/users/defunkt",
                htmlUrl: "https://github.com/defunkt",
                followersUrl: "https://api.github.com/users/defunkt/followers",
                followingUrl: "https://api.github.com/users/defunkt/following{/other_user}",
                gistsUrl: "https://api.github.com/users/defunkt/gists{/gist_id}",
                starredUrl: "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
                subscriptionsUrl: "https://api.github.com/users/defunkt/subscriptions",
                organizationsUrl: "https://api.github.com/users/defunkt/orgs",
                reposUrl: "https://api.github.com/users/defunkt/repos",
                eventsUrl: "https://api.github.com/users/defunkt/events{/privacy}",
                receivedEventsUrl: "https://api.github.com/users/defunkt/received_events",
                type: "User",
                userViewType: "public",
                siteAdmin: false
            ),
            GitHubUser(
                login: "pjhyett",
                id: 3,
                nodeId: "MDQ6VXNlcjM=",
                avatarUrl: "https://avatars.githubusercontent.com/u/3?v=4",
                gravatarId: nil,
                url: "https://api.github.com/users/pjhyett",
                htmlUrl: "https://github.com/pjhyett",
                followersUrl: "https://api.github.com/users/pjhyett/followers",
                followingUrl: "https://api.github.com/users/pjhyett/following{/other_user}",
                gistsUrl: "https://api.github.com/users/pjhyett/gists{/gist_id}",
                starredUrl: "https://api.github.com/users/pjhyett/starred{/owner}{/repo}",
                subscriptionsUrl: "https://api.github.com/users/pjhyett/subscriptions",
                organizationsUrl: "https://api.github.com/users/pjhyett/orgs",
                reposUrl: "https://api.github.com/users/pjhyett/repos",
                eventsUrl: "https://api.github.com/users/pjhyett/events{/privacy}",
                receivedEventsUrl: "https://api.github.com/users/pjhyett/received_events",
                type: "User",
                userViewType: "public",
                siteAdmin: false
            ),
            GitHubUser(
                login: "wycats",
                id: 4,
                nodeId: "MDQ6VXNlcjQ=",
                avatarUrl: "https://avatars.githubusercontent.com/u/4?v=4",
                gravatarId: nil,
                url: "https://api.github.com/users/wycats",
                htmlUrl: "https://github.com/wycats",
                followersUrl: "https://api.github.com/users/wycats/followers",
                followingUrl: "https://api.github.com/users/wycats/following{/other_user}",
                gistsUrl: "https://api.github.com/users/wycats/gists{/gist_id}",
                starredUrl: "https://api.github.com/users/wycats/starred{/owner}{/repo}",
                subscriptionsUrl: "https://api.github.com/users/wycats/subscriptions",
                organizationsUrl: "https://api.github.com/users/wycats/orgs",
                reposUrl: "https://api.github.com/users/wycats/repos",
                eventsUrl: "https://api.github.com/users/wycats/events{/privacy}",
                receivedEventsUrl: "https://api.github.com/users/wycats/received_events",
                type: "User",
                userViewType: "public",
                siteAdmin: false
            ),
            GitHubUser(
                login: "ezmobius",
                id: 5,
                nodeId: "MDQ6VXNlcjU=",
                avatarUrl: "https://avatars.githubusercontent.com/u/5?v=4",
                gravatarId: nil,
                url: "https://api.github.com/users/ezmobius",
                htmlUrl: "https://github.com/ezmobius",
                followersUrl: "https://api.github.com/users/ezmobius/followers",
                followingUrl: "https://api.github.com/users/ezmobius/following{/other_user}",
                gistsUrl: "https://api.github.com/users/ezmobius/gists{/gist_id}",
                starredUrl: "https://api.github.com/users/ezmobius/starred{/owner}{/repo}",
                subscriptionsUrl: "https://api.github.com/users/ezmobius/subscriptions",
                organizationsUrl: "https://api.github.com/users/ezmobius/orgs",
                reposUrl: "https://api.github.com/users/ezmobius/repos",
                eventsUrl: "https://api.github.com/users/ezmobius/events{/privacy}",
                receivedEventsUrl: "https://api.github.com/users/ezmobius/received_events",
                type: "User",
                userViewType: "public",
                siteAdmin: false
            )
        ]
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
    
    static func mockList() -> [GitHubUserDTO] {
        return [
            GitHubUserDTO(
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
            ),
            GitHubUserDTO(
                login: .value("defunkt"),
                id: .value(2),
                nodeId: .value("MDQ6VXNlcjI="),
                avatarUrl: .value("https://avatars.githubusercontent.com/u/2?v=4"),
                gravatarId: nil,
                url: .value("https://api.github.com/users/defunkt"),
                htmlUrl: .value("https://github.com/defunkt"),
                followersUrl: .value("https://api.github.com/users/defunkt/followers"),
                followingUrl: .value("https://api.github.com/users/defunkt/following{/other_user}"),
                gistsUrl: .value("https://api.github.com/users/defunkt/gists{/gist_id}"),
                starredUrl: .value("https://api.github.com/users/defunkt/starred{/owner}{/repo}"),
                subscriptionsUrl: .value("https://api.github.com/users/defunkt/subscriptions"),
                organizationsUrl: .value("https://api.github.com/users/defunkt/orgs"),
                reposUrl: .value("https://api.github.com/users/defunkt/repos"),
                eventsUrl: .value("https://api.github.com/users/defunkt/events{/privacy}"),
                receivedEventsUrl: .value("https://api.github.com/users/defunkt/received_events"),
                type: .value("User"),
                userViewType: .value("public"),
                siteAdmin: .value(false)
            ),
            GitHubUserDTO(
                login: .value("pjhyett"),
                id: .value(3),
                nodeId: .value("MDQ6VXNlcjM="),
                avatarUrl: .value("https://avatars.githubusercontent.com/u/3?v=4"),
                gravatarId: nil,
                url: .value("https://api.github.com/users/pjhyett"),
                htmlUrl: .value("https://github.com/pjhyett"),
                followersUrl: .value("https://api.github.com/users/pjhyett/followers"),
                followingUrl: .value("https://api.github.com/users/pjhyett/following{/other_user}"),
                gistsUrl: .value("https://api.github.com/users/pjhyett/gists{/gist_id}"),
                starredUrl: .value("https://api.github.com/users/pjhyett/starred{/owner}{/repo}"),
                subscriptionsUrl: .value("https://api.github.com/users/pjhyett/subscriptions"),
                organizationsUrl: .value("https://api.github.com/users/pjhyett/orgs"),
                reposUrl: .value("https://api.github.com/users/pjhyett/repos"),
                eventsUrl: .value("https://api.github.com/users/pjhyett/events{/privacy}"),
                receivedEventsUrl: .value("https://api.github.com/users/pjhyett/received_events"),
                type: .value("User"),
                userViewType: .value("public"),
                siteAdmin: .value(false)
            ),
            GitHubUserDTO(
                login: .value("wycats"),
                id: .value(4),
                nodeId: .value("MDQ6VXNlcjQ="),
                avatarUrl: .value("https://avatars.githubusercontent.com/u/4?v=4"),
                gravatarId: nil,
                url: .value("https://api.github.com/users/wycats"),
                htmlUrl: .value("https://github.com/wycats"),
                followersUrl: .value("https://api.github.com/users/wycats/followers"),
                followingUrl: .value("https://api.github.com/users/wycats/following{/other_user}"),
                gistsUrl: .value("https://api.github.com/users/wycats/gists{/gist_id}"),
                starredUrl: .value("https://api.github.com/users/wycats/starred{/owner}{/repo}"),
                subscriptionsUrl: .value("https://api.github.com/users/wycats/subscriptions"),
                organizationsUrl: .value("https://api.github.com/users/wycats/orgs"),
                reposUrl: .value("https://api.github.com/users/wycats/repos"),
                eventsUrl: .value("https://api.github.com/users/wycats/events{/privacy}"),
                receivedEventsUrl: .value("https://api.github.com/users/wycats/received_events"),
                type: .value("User"),
                userViewType: .value("public"),
                siteAdmin: .value(false)
            ),
            GitHubUserDTO(
                login: .value("ezmobius"),
                id: .value(5),
                nodeId: .value("MDQ6VXNlcjU="),
                avatarUrl: .value("https://avatars.githubusercontent.com/u/5?v=4"),
                gravatarId: nil,
                url: .value("https://api.github.com/users/ezmobius"),
                htmlUrl: .value("https://github.com/ezmobius"),
                followersUrl: .value("https://api.github.com/users/ezmobius/followers"),
                followingUrl: .value("https://api.github.com/users/ezmobius/following{/other_user}"),
                gistsUrl: .value("https://api.github.com/users/ezmobius/gists{/gist_id}"),
                starredUrl: .value("https://api.github.com/users/ezmobius/starred{/owner}{/repo}"),
                subscriptionsUrl: .value("https://api.github.com/users/ezmobius/subscriptions"),
                organizationsUrl: .value("https://api.github.com/users/ezmobius/orgs"),
                reposUrl: .value("https://api.github.com/users/ezmobius/repos"),
                eventsUrl: .value("https://api.github.com/users/ezmobius/events{/privacy}"),
                receivedEventsUrl: .value("https://api.github.com/users/ezmobius/received_events"),
                type: .value("User"),
                userViewType: .value("public"),
                siteAdmin: .value(false)
            )
        ]
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
