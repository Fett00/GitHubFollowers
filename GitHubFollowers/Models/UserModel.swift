//
//  User.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 07.06.2021.
//

import Foundation

struct UserModel {
    let login: String
    let id: Int
    let avatar_url: String
    let url: String
    let followers_url: String
    let organizations_url: String
    let name: String
    let company: String
    let location: String
    let bio: String
    let public_repos: Int
    let followers: Int
    let following: Int
    let created_at: Date
}

