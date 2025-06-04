import Observation
import Foundation
import SwiftData

@MainActor
@Observable
final class UserListObservable {
    var isLoading = false
    var isLoadmore = false
    var userList = [GitHubUser]()
    var errorMessage: String?
    
    private let service: UserService
    private var page = 0
    private let itemPerPage = 20
    private let modelContainer: ModelContainer
    
    init (service: UserService, modelContainer: ModelContainer) {
        self.service = service
        self.modelContainer = modelContainer
        Task {
            loadCache()
            await loadFirstPage(needLoading: userList.isEmpty)
        }
    }
    
    private func loadCache() {
        let userListFetchDescriptor = FetchDescriptor<GithubUserSwiftData>(sortBy: [SortDescriptor(\GithubUserSwiftData.id)])
        let cachedUserList = (try? modelContainer.mainContext.fetch(userListFetchDescriptor)) ?? []
        userList = cachedUserList.map { $0.toDomain() }
    }
    
    private func saveCache(userList: [GitHubUser]) {
        let userListFetchDescriptor = FetchDescriptor<GithubUserSwiftData>()
        do {
            let oldCache = try modelContainer.mainContext.fetch(userListFetchDescriptor)
            oldCache.forEach { cache in
                modelContainer.mainContext.delete(cache)
            }
            try modelContainer.mainContext.save()
            
            userList.forEach { user in
                modelContainer.mainContext.insert(user.toSwiftData())
            }
            try modelContainer.mainContext.save()
        } catch {
            
        }
    }
    
    func loadFirstPage(needLoading: Bool) async {
        defer {
            isLoading = false
        }
        page = 0
        isLoading = true
        do {
            if ProcessInfo.processInfo.arguments.contains("UI_TESTING") && ProcessInfo.processInfo.arguments.contains("FORCE_ERROR") {
                throw APIError(message: "Test error")
            }
            let result = try await service.fetchUsers(perPage: itemPerPage, since: page * itemPerPage)
            userList = result
            page += 1
            saveCache(userList: result)
        } catch {
            errorMessage = (error as? APIError)?.message ?? error.localizedDescription
            userList = []
        }
    }
    
    func loadMore() async {
        defer {
            isLoadmore = false
        }
        guard page > 0, !isLoadmore else {
            return
        }
        isLoadmore = true
        
        do {
            for user in try await service.fetchUsers(perPage: itemPerPage, since: page * itemPerPage) {
                // github API return some duplicated users, so we need to check if they already existed
                if !userList.map({ $0.id }).contains(user.id) {
                    userList.append(user)
                }
            }
            page += 1
        } catch {
            // do nothing
            print(error)
        }
    }
}
