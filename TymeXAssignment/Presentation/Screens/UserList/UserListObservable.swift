import Observation

@MainActor
@Observable
final class UserListObservable {
    var isLoading = false
    var isLoadmore = false
    var userList = [GitHubUser]()
    var error: Error?
    
    private let service: UserService
    private var page = 0
    private let itemPerPage = 20
    
    init (service: UserService) {
        self.service = service
        Task {
            await loadFirstPage(needLoading: true)
        }
    }
    
    func loadFirstPage(needLoading: Bool) async {
        defer {
            isLoading = false
        }
        page = 0
        isLoading = true
        do {
            let result = try await service.fetchUsers(perPage: itemPerPage, since: page)
            userList = result
            page += 1
        } catch {
            self.error = error
            userList = []
        }
    }
    
    func loadMore() async {
        defer {
            isLoadmore = false
        }
        guard page > 0, !isLoadmore, userList.count >= itemPerPage else {
            return
        }
        isLoadmore = true
        
        do {
            let result = try await service.fetchUsers(perPage: itemPerPage, since: page)
            userList += result
            page += 1
        } catch {
            // do nothing
            print(error)
        }
    }
}
