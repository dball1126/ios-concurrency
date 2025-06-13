//
//  ContentView.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/5/25.
//

import SwiftUI

struct UsersListView: View {
    #warning("remove the forPreview arguement or set it to false before uploading to App store")
    @StateObject var vm = UsersListViewModel(forPreview: false)
    @State var textColor: Color = .blue // Mark textColor as @State
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.users) { user in
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                                .foregroundStyle(textColor)
                            Text(user.email)
            
                        }
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
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear {
                vm.fetchUsers()
                

            }
        }
    }
    func setTimeout(delay: TimeInterval, callback: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay)
        {
            callback()
        }
    }
}

#Preview {
    UsersListView()
}

//
//// --- Example Usage ---
//NSLog("**********************************************")
//print("**********************************************")
//print("Task started at \(Date())")
//
//// Simulate a 2-second timeout
//setTimeout(delay: 10.0) {
//    NSLog("**********************************************")
//    print("**********************************************")
//    print("Callback executed after 10 seconds at \(Date())")
//    self.textColor = .green
//    print("**********************************************")
//    NSLog("**********************************************")
//}
//
//// Simulate a 0.5-second timeout
//setTimeout(delay: 5.0) {
//    NSLog("**********************************************")
//    print("**********************************************")
//    print("Another callback executed after 5 seconds at \(Date())")
//    self.textColor = .red
//    print("**********************************************")
//    NSLog("**********************************************")
//}
//
//print("Main thread continues immediately.")
//print("**********************************************")
//NSLog("**********************************************")
