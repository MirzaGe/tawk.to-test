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
    var endpoint: EndpointType { get }
}

extension RequestType {
    func execute(
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        completion: @escaping ResultCallback<ResponseType>) {
        dispatcher.dispatch(request: self.data, onSuccess: { (data: Data) in
            do {
                var responseData = data
                
                if AppEnv.currentEnv == .unitUITest {
                    switch self.endpoint {
                    case .getUsers:
                        responseData = StubbingUtility.stubbedResponse("Users")
                    case .getUser:
                        responseData = StubbingUtility.stubbedResponse("GetUser")
                    }
                }
                
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "Error Core Data", code: 0, userInfo: nil)))
                    }
                    
                    return
                }
                
                let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                let result = try decoder.decode(ResponseType.self, from: responseData)
                
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
