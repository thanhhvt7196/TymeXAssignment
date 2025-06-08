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
    
    @ObservationIgnored private let usecase: UserListUsecase
    @ObservationIgnored private var page = 0
    @ObservationIgnored private let itemPerPage = 20
        
    init(usecase: UserListUsecase) {
        self.usecase = usecase
        Task {
            loadCache()
            await loadFirstPage(needLoading: userList.isEmpty)
        }
    }
    
    internal func loadCache() {
        userList = usecase.getAllUsersFromCache()
    }
    
    internal func saveCache(userList: [GitHubUser]) {
        usecase.cleanCache()
        usecase.saveCache(users: userList)
    }
    
    func loadFirstPage(needLoading: Bool) async {
        defer {
            isLoading = false
        }
        page = 0
        isLoading = true
        do {
            let result = try await usecase.fetchUsers(perPage: itemPerPage, since: page * itemPerPage)
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
            let newUsers = try await usecase.fetchUsers(perPage: itemPerPage, since: page * itemPerPage)
            if !newUsers.isEmpty {
                for user in newUsers {
                    // github API return some duplicated users, so we need to check if they already existed
                    if !userList.map({ $0.id }).contains(user.id) {
                        userList.append(user)
                    }
                }
                page += 1
            }
        } catch {
            // do nothing
            print(error)
        }
    }
}
