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
    let name, full_name, description, language: String?
    let stargazers_count: Int?
    let owner: OwnerData?
    
}

struct OwnerData: Codable, Equatable {
    let login: String?
}



// MARK: - User

struct SearchUserModel: Codable, Parseable, Equatable {
    typealias ParseableType = SearchUserModel
    
    let name, avatar_url: String?
    let message: String?
}
