//
//  AuthService.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

class AuthService {

    private static let factory = RequestFactory()
    private static var authFactory: AuthRequestFactory?
    
    private static func sendRequest<T>(
        modelType: T.Type,
        requestOptions: AuthRequestRouter,
        completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        authFactory = factory.makeAuthFactory()
        authFactory?.sendRequest(modelType: modelType, requestOptions: requestOptions, completion: { result in
            completion(result)
        })
    }
    
    private static func sendRequest(
        requestOptions: AuthRequestRouter,
        completion: @escaping (Result<Bool, Error>) -> Void) {
        authFactory = factory.makeAuthFactory()
        authFactory?.sendRequest(requestOptions: requestOptions, completion: { result in
            completion(result)
        })
    }
    
    static func signUp(name: String, email: String, password: String, completion: @escaping (Result<AuthenticationResult, Error>) -> Void) {
        let parameters: [String: Any] = ["name": name,
                                         "email": email,
                                         "password": password,
                                         "isDebug": true]
        sendRequest(modelType: AuthenticationResult.self, requestOptions: .signUp(parameters: parameters)) { result in
            completion(result)
        }
    }
    
    static func login(email: String, password: String, completion: @escaping (Result<AuthenticationResult, Error>) -> Void) {
        let parameters: [String: Any] = ["email" : email,
                                         "password" : password]
        sendRequest(modelType: AuthenticationResult.self, requestOptions: .login(parameters: parameters)) { result in
            completion(result)
        }
    }
    
    static func logout(completion: @escaping (Result<Bool, Error>) -> Void) {
        sendRequest(requestOptions: .logout) { result in
            completion(result)
        }
    }
}

