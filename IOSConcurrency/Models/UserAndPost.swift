//
//  UserAndPost.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/19/25.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberOfPosts: Int {
        posts.count
    }
}
