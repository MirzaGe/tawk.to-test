//
//  RequestType.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import CoreData
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
                //let jsonDecoder = JSONDecoder()
                //let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve managed object context")
                }
                
                let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                let result = try decoder.decode(ResponseType.self, from: responseData)
                
                CoreDataStack.shared.saveContext()
                
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
