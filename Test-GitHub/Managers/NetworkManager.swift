//
//  NetworkManager.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let alamofireManager: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        self.alamofireManager = Session(configuration: configuration)
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
