//
//  User.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 07.06.2021.
//

import UIKit

struct UserModel: Codable {

    let login: String
    let id: Int
    let avatarUrl: String
    var avatarImage:UIImage?
    let url: String
    let followersUrl: String
    var followersModel = [FollowerModel]()
    let followingUrl: String
    let name: String?
    let company: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case name
        case company
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case created = "created_at"
    }
}

