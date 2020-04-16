//
//  RequestType.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

extension RequestType {
    func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: ((ResponseType) -> Void)? = nil,
        onSuccessRawData: ((Data) -> Void)? = nil,
        onError: @escaping (Error) -> Void) {
        dispatcher.dispatch(request: self.data, onSuccess: { (responseData: Data) in
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                
                DispatchQueue.main.async {
                    onSuccess?(result)
                }
            } catch let error {
                DispatchQueue.main.async {
                    if self is APIManager.GetFile {
                        onSuccessRawData?(responseData)
                        return
                    }
                    onError(error)
                }
            }
        }, onError: { (error: Error) in
            DispatchQueue.main.async {
                onError(error)
            }
        })
    }
}
