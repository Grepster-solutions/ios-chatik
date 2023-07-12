//
//  ChatsRequestRouter.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import Foundation


enum ChatsRequestRouter: AbstractRequestRouter {
    case list
    case create(companionUUIDs: [UUID])
    
    var path: String {
        switch self {
        case .list, .create:
            return "/chats"
        }
    }
    
    var headers: [String: String] {
        guard let token = AuthController.getToken() else { return [:] }
        switch self {
        case .list, .create:
            return ["Content-Type": "application/json",
                    "x-access-token": "\(token)"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .create:
            return .post
        }
    }
    
    var parameters: HTTPParameters? {
        switch self {
        case .list:
            return nil
        case .create(let companionUUIDs):
            return ["companion_ids": companionUUIDs.map { $0.uuidString }]
        }
    }
    
    var arguments: HTTPArguments? {
        return nil
    }
    
}
