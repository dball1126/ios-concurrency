//
//  IOSConcurrencyApp.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/5/25.
//

import SwiftUI

@main
struct IOSConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            UsersListView()
                .onAppear {
                    UserDefaults.standard.set(true, forKey: "_UIConstraintBaedLayoutLogUnsatisfiable")
                    
                }
        }
    }
    
    func setTimeout(delay: TimeInterval, callback: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            callback()
        }
    }
}
