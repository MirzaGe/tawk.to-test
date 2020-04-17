//
//  APIManager.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

let baseURL = "https://api.github.com/users"

struct APIManager {
    /// Get all the users with `since` as parameter.
    /// `since` - the last seen user id
    struct GetUsers: RequestType {
        typealias ResponseType = [User]
        var parameters: [String : Any]?
        var data: RequestData {
            return RequestData(path: baseURL, method: .get, params: self.parameters, headers: nil)
        }
    }
    
    /// Get specific user by `id`.
    struct GetUser: RequestType {
        typealias ResponseType = User
        var userId: Int
        var data: RequestData {
            return RequestData(path: "\(baseURL)/\(userId)", method: .get, params: nil, headers: nil)
        }
    }
}
