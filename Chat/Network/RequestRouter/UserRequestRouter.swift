//
//  UserRequestRouter.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit

enum UserRequestRouter: AbstractRequestRouter {
    case currentUser
    case usersForChat
    
    var method: HTTPMethod {
        switch self {
        case .currentUser, .usersForChat:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .currentUser:
            return "/current_user"
        case .usersForChat:
            return "/users_for_chats"
        }
    }
    
     var headers: HTTPHeaders {
         guard let token = AuthController.getToken() else {
             return ["Content-Type": "application/json"]
         }
         switch self {
         case .currentUser:
             return ["Content-Type": "application/json",
                     "x-access-token" : "\(token)"]
         case .usersForChat:
             return ["x-access-token" : "\(token)"]
         }
    }
    
    var parameters: HTTPParameters? {
        switch self {
        case .currentUser, .usersForChat:
            return nil
        }
    }
    
}


