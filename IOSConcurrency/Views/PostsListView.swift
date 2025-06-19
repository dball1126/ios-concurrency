//
//  PostsListView.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/11/25.
//
import SwiftUI
import Foundation

struct PostsListView: View {
    @StateObject var vm = PostsListViewModel(forPreview: true)
    var userId: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundColor(.secondary)
        
                    }
                }
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView()
                }
            })
            .alert("Application Error", isPresented: $vm.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .task {
                vm.userId = userId
                await vm.fetchPosts()
            }
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }

    }
}
