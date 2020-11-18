//
//  NetworkManager.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import Foundation
import Alamofire

enum HttpMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

class NetworkManager {
    
    private let alamofireManager: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        self.alamofireManager = SessionManager(configuration: configuration)
    }
    
    func get(endpoint: String,
             parameters: Parameters?,
             headers: HTTPHeaders?,
             completion: @escaping (Any?, Data?, Error?) -> Void) {
        
        self.request(endpoint: endpoint,
                     parameters: parameters,
                     headers: headers,
                     method: .get,
                     completion: completion)
        
    }
    
    func post(endpoint: String,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completion: @escaping (Any?, Data?, Error?) -> Void) {
        
        self.request(endpoint: endpoint,
                     parameters: parameters,
                     headers: headers,
                     method: .post,
                     completion: completion)
        
    }
    
    func put(endpoint: String,
             parameters: Parameters?,
             headers: HTTPHeaders?,
             completion: @escaping (Any?, Data?, Error?) -> Void) {
        
        self.request(endpoint: endpoint,
                     parameters: parameters,
                     headers: headers,
                     method: .put,
                     completion: completion)
        
    }
    
    func delete(endpoint: String,
                parameters: Parameters?,
                headers: HTTPHeaders?,
                completion: @escaping (Any?, Data?, Error?) -> Void) {
        
        self.request(endpoint: endpoint,
                     parameters: parameters,
                     headers: headers,
                     method: .delete,
                     completion: completion)
        
    }
    
    private func request(endpoint: String,
                         parameters: Parameters?,
                         headers: HTTPHeaders?,
                         method: HTTPMethod,
                         completion: @escaping (Any?, Data?, Error?) -> Void) {
        
        let fullUrl = NetworkConfiguration.BaseURL + endpoint
        
        self.alamofireManager.request(fullUrl,
                                      method: method,
                                      parameters: parameters,
                                      encoding: JSONEncoding.default,
                                      headers: headers).responseJSON(completionHandler: { response in
                                        
                                        switch response.result {
                                        case .success:
                                            completion(response.value, response.data, nil)
                                        case .failure:
                                            completion(nil, nil, response.error)
                                        }
                                      })
    }
}
