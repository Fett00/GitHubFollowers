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
    let avatarUrl: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
    }
}

struct FollowerModelK: Codable{
    
    let login:String
    let avatarURL:String
    let url:String
    let receivedEventsUrl:String
    
    enum CodingKeys:String,CodingKey{
        
        case login
        case avatarURL = "avatar_url"
        case url
        case receivedEventsUrl = "received_events_url"
    }
}
