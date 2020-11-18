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
    
    func getSearchList(searchText: String, completion: @escaping (SearchResultModel) -> ()) {
        
        sessionManager?.get(endpoint: NetworkEndpointType.search.name + "\(searchText)+language:swift&sort=stars@order=desc", parameters: nil, headers: nil, completion: { (result, data, error) in
            print(result ?? "")
            print("Validation Successful")
            
            if result != nil {
                
                guard let decodeData = SearchResultModel.decodeFromData(data: data!) else {
                    print("Decode error")
                    return
                }
                
                completion(decodeData)
            }
        })
    }
    
    func getSearchUser(searchText: String, completion: @escaping (SearchUserModel) -> ()) {
        
        sessionManager?.get(endpoint: NetworkEndpointType.users.name + searchText, parameters: nil, headers: nil, completion: { (result, data, error) in
            print(result ?? "")
            print("Validation Successful")
            
            if result != nil {
                
                guard let decodeData = SearchUserModel.decodeFromData(data: data!) else {
                    print("Decode error")
                    return
                }
                
                completion(decodeData)
            }
        })
    }


}
