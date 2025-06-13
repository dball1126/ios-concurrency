//
//  User.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/5/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
