//
//  MessagesRequestRouter.swift
//  Chat
//
//  Created by Дарья on 04.11.2022.
//

import UIKit
import Alamofire

public enum MessagesRequestRouter: AbstractRequestRouter {
    case postMessage(parameters: Parameters)
    case getMessageList(parameters: Parameters)
    case getCompanions
    
    var method: HTTPMethod {
        switch self {
        case .postMessage:
            return .post
        case .getMessageList, .getCompanions:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .postMessage, .getMessageList:
            return "/messages"
        case .getCompanions:
            return "users_for_chats"
        }
    }
    
     var headers: HTTPHeaders {
         guard let token = AuthController.getToken() else {
             return ["Content-Type": "application/json"]
         }
         switch self {
         case .postMessage,
              .getMessageList,
              .getCompanions:
             return ["Content-Type": "application/json",
                     "x-access-token" : "\(token)"]
         }
    }
    
    struct CustomPatchEncding: ParameterEncoding {
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            let mutableRequest = try? URLEncoding().encode(urlRequest, with: parameters) as? NSMutableURLRequest
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
                mutableRequest?.httpBody = jsonData
                
            } catch {
                debugPrint(error.localizedDescription)
            }
            return mutableRequest! as URLRequest
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        switch self {
        case .postMessage(let parameters),
             .getMessageList(let parameters):
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: parameters)
        case .getCompanions:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        print("---- urlRequest: \(urlRequest) ----")
        return urlRequest
    }
}



