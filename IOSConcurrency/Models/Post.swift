//
//  Post.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/5/25.
//

import Foundation

struct Post:  Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
