//
//  URLSessionNetworkDispatcher.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

struct URLSessionNetworkDispatcher: NetworkDispatcher {
    static let instance = URLSessionNetworkDispatcher()
    init() {}
    
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnectionError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let params = request.params {
            
            let urlParams = params.compactMap({ (key, value) -> String in
                return "\(key)=\(value ?? "")"
            }).joined(separator: "&")

            
            if let newURL = URL(string: url.absoluteString + "?" + urlParams) {
                urlRequest = URLRequest(url: newURL)
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnectionError.noData)
                return
            }
            
            onSuccess(_data)
            }.resume()
    }
}
