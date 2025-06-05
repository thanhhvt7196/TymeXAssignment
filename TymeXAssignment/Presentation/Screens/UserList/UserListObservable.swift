import Observation
import Foundation
import SwiftData

@MainActor
@Observable
final class UserListObservable {
    var isLoading = false
    @ObservationIgnored var isLoadmore = false
    var userList = [GitHubUser]()
    var errorMessage: String?
    
    @ObservationIgnored private let service: UserService
    @ObservationIgnored private var page = 0
    @ObservationIgnored private let itemPerPage = 20
    @ObservationIgnored private let store: GithubUserStore
        
    init (service: UserService, modelContainer: ModelContainer) {
        self.service = service
        self.store = GithubUserStoreImpl(collection: SwiftDataStore<GithubUserSwiftData>(modelContext: modelContainer.mainContext))
        Task {
            loadCache()
            await loadFirstPage(needLoading: userList.isEmpty)
        }
    }
    
    private func loadCache() {
        userList = store.getAllUsers()
    }
    
    private func saveCache(userList: [GitHubUser]) {
        store.clean()
        store.add(users: userList)
    }
    
    func loadFirstPage(needLoading: Bool) async {
        defer {
            isLoading = false
        }
        page = 0
        isLoading = true
        do {
            let result = try await service.fetchUsers(perPage: itemPerPage, since: page * itemPerPage)
            userList = result
            page += 1
            saveCache(userList: result)
        } catch {
            errorMessage = (error as? APIError)?.message ?? error.localizedDescription
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
