//
//  FollowerModel.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 17.06.2021.
//

import Foundation

struct FollowerModel: Codable {
    
    let login: String
    let id: Int
    let avatar_url: String
    let url: String
}
