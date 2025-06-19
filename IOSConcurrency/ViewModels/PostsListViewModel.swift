//
//  PostsListViewModel.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/11/25.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var userId: Int?
    @Published var isLoading: Bool = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchPosts() async {
        if let userId = userId {
                isLoading.toggle()
                let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            defer {
                isLoading.toggle()
            }
            
            do {
                
                posts = try await apiService.getJSON()
            } catch {
                showAlert = true
                errorMessage = error.localizedDescription + "\n Please contact support"
            }
        }
    }
}
extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUsersPostsArray
        }
    }
}
