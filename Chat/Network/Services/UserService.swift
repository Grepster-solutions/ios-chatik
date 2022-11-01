//
//  UserService.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit

class UserService {

    private static let factory = RequestFactory()
    private static var userFactory: UserRequestFactory?
    
    private static func sendRequest<T>(
        modelType: T.Type,
        requestOptions: UserRequestRouter,
        completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        userFactory = factory.makeUserFactory()
        userFactory?.sendRequest(modelType: modelType, requestOptions: requestOptions, completion: { result in
            completion(result)
        })
    }
    
    private static func sendRequest(
        requestOptions: UserRequestRouter,
        completion: @escaping (Result<Bool, Error>) -> Void) {
        userFactory = factory.makeUserFactory()
        userFactory?.sendRequest(requestOptions: requestOptions, completion: { result in
            completion(result)
        })
    }
    
    static func getCurrentUser(_ completion: @escaping (Result<User, Error>) -> Void) {
        sendRequest(modelType: User.self, requestOptions: .getCurrentUser) { result in
            completion(result)
        }
    }
}


