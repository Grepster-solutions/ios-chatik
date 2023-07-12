//
//  AuthRequestRouter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

enum AuthRequestRouter: AbstractRequestRouter {
    case signUp(name: String, email: String, password: String)
    case login(email: String, password: String)
    case logout
    
    var method: HTTPMethod {
        switch self {
        case .signUp, .login:
            return .post
        case .logout:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/signup"
        case .login:
            return "/login"
        case .logout:
            return "/remove_account"
        }
    }
    
     var headers: HTTPHeaders {
         switch self {
         case .signUp, .login:
             return ["Content-Type": "application/json"]
         case .logout:
             guard let token = AuthController.getToken() else {
                 return [:]
             }
             return ["Content-Type": "application/json",
                     "x-access-token": "\(token)"]
         }
    }
    
    var parameters: HTTPParameters? {
        switch self {
        case .signUp(let name, let email, let password):
            return ["name": name,
                    "email": email,
                    "password": password,
                    "isDebug": true]
        case .login(let email, let password):
            return ["email" : email,
                    "password" : password]
        case .logout:
            return nil
        }
    }
    
    var arguments: HTTPArguments? {
        return nil
    }
    
}

