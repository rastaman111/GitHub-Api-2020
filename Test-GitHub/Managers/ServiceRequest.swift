//
//  ServiceRequest.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import Foundation
import Alamofire

class ServiceRequest {
    
    var sessionManager: NetworkManager?
    
    init() {
        sessionManager = NetworkManager()
    }
    
    public func getSearchList(searchText: String, completion: @escaping (Result<SearchResultModel, Error>) -> ()) {
        
        sessionManager?.get(endpoint: NetworkEndpointType.search.name + "\(searchText)+language:swift&sort=stars@order=desc", parameters: nil, headers: nil, completion: { (result, data, error) in
            print("Validation Successful")
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                guard let decodeData = SearchResultModel.decodeFromData(data: data) else {
                    print("Decode error")
                    return
                }
                
                completion(.success(decodeData))
            }
        })
    }
    
    public func getSearchUser(searchText: String, completion: @escaping (Result<SearchUserModel, Error>) -> ()) {
        
        sessionManager?.get(endpoint: NetworkEndpointType.users.name + searchText, parameters: nil, headers: nil, completion: { (result, data, error) in
            print("Validation Successful")
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                guard let decodeData = SearchUserModel.decodeFromData(data: data) else {
                    print("Decode error")
                    return
                }
                completion(.success(decodeData))
            }
        })
    }
}
