//
//  UsersListViewModel.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/8/25.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    func fetchUsers() {
        let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        apiService.getJSON { (result: Result<[User], APIError>) in
            defer {
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
            }
            switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case .failure(let error):
                    print("Error: \(error)")
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription + "\n Please ocntact the developer and proivde this error "
                }
            }
        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}
