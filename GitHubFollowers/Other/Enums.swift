//
//  Enums.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 27.05.2021.
//

import Foundation
import UIKit

enum SFSymbols {
    
    static let location = UIImage(systemName: "mappin.and.ellipse")!
    static let search = UIImage(systemName: "magnifyingglass")!
    static let repos = UIImage(systemName: "folder")!
    static let gists = UIImage(systemName: "text.alignleft")!
    static let heart = UIImage(systemName: "heart")!
    static let persons = UIImage(systemName: "person.2")!
    static let starFill = UIImage(systemName: "star.fill")!
    static let star = UIImage(systemName: "star")
    static let person = UIImage(systemName: "person")!
}

enum Images {
    
    static let ghLogo = UIImage(named: "gh-logo")!
    static let placeHolder = UIImage(named: "avatar-placeholder")!
    static let emptyState = UIImage(named: "empty-state-logo")!
}

enum Titles{
    
    static let emptyName = "The text field are empty.💁\n Please try enter name!✎"
}

enum NetworkError: String, Error { //Написать нормальные ошибки
    
    case badResponse = "Bad response."
    case failure = "Failure!"
}
