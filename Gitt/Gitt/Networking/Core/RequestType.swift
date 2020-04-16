//
//  RequestType.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

public typealias ResultCallback<T> = (Result<T, Error>) -> Void

protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

extension RequestType {
    func execute(
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        completion: @escaping ResultCallback<ResponseType>) {
        dispatcher.dispatch(request: self.data, onSuccess: { (responseData: Data) in
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }, onError: { (error: Error) in
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        })
    }
}
