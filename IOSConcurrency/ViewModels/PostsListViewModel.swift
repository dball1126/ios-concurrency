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
    func fetchPosts() {
        if let userId = userId {
                isLoading.toggle()
                let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
                apiService.getJSON { (result: Result<[Post], APIError>) in
                    defer {
                        DispatchQueue.main.async {
                            self.isLoading.toggle()
                        }
                    }
                    switch result {
                        case .success(let posts):
                            DispatchQueue.main.async {
                                self.posts = posts
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
}
extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUsersPostsArray
        }
    }
}
