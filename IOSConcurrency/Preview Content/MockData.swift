//
//  MockData.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/11/25.
//

import Foundation

extension User {
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    static var mockSingleUser: User {
        Self.mockUsers[0]
    }
}

extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    static var mockSinglePost: Post {
        Self.mockPosts[0]
    }
    
    static var mockSingleUsersPostsArray: [Post] {
        Self.mockPosts.filter{$0.userId == 1}
    }
}
