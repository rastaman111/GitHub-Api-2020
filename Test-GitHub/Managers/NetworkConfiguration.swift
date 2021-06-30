//
//  NetworkConfiguration.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import Foundation

struct NetworkConfiguration {
  
  static var BaseURL: String = {
    
    guard let mainDictionary = Bundle.main.object(forInfoDictionaryKey: "API") as? [String: Any] else {
      fatalError("No main directory API in Info.plist file, please add it.")
    }
    
    guard let baseURL = mainDictionary["Api SDK"] else {
      fatalError("No BaseURL found in Info.plist file, please add it.")
    }
    
    guard let baseUrlString = baseURL as? String else {
      fatalError("BaseURL not valid String in Info.plist file, please check it.")
    }
    
    return baseUrlString
  }()
}

enum NetworkEndpointType {
    case search
    case users
    
    var name: String {
        switch self {
        case .search:
            return "/search/repositories?q="
        case .users:
            return "/users/"
        }
    }
}
