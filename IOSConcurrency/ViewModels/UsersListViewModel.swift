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
    
    @MainActor
    func fetchUsers() async {
        let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        
        do {
            
            users = try await apiService.getJSON()
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\n Please contact support"
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
