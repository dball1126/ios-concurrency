//
//  PostsListView.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/11/25.
//
import SwiftUI
import Foundation

struct PostsListView: View {
    var posts: [Post]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundColor(.secondary)
        
                    }
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)

        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(posts: Post.mockSingleUsersPostsArray)
        }

    }
}
