//
//  SearchResultModel.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import Foundation

// MARK: - Search

struct SearchResultModel: Codable, Parseable, Equatable {
    typealias ParseableType = SearchResultModel
    
    let items: [ItemsResults]?
    let message: String?
}

// MARK: - SearchData
struct ItemsResults: Codable, Equatable {
    let name, fullName, description, language: String?
    let stargazersCount: Int?
    let owner: OwnerData?
    
    enum CodingKeys: String, CodingKey {
        case name, description, language
        case owner
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
    }
}

struct OwnerData: Codable, Equatable {
    let login: String?
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}



// MARK: - User

struct SearchUserModel: Codable, Parseable, Equatable {
    typealias ParseableType = SearchUserModel
    
    let login, name, avatarUrl, message, location: String?
    let followers, following: Int
    
    enum CodingKeys: String, CodingKey {
        case login, name, message, location
        case followers, following
        case avatarUrl = "avatar_url"
    }
}
