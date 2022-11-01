//
//  AuthRequestRouter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import Alamofire

public enum AuthRequestRouter: AbstractRequestRouter {
    case signUp(parameters: Parameters)
    case login(parameters: Parameters)
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
         guard let token = AuthController.getToken() else {
             return ["Content-Type": "application/json"]
         }
         switch self {
         case .signUp, .login:
             return ["Content-Type": "application/json"]
         case .logout:
             return ["Content-Type": "application/json",
                     "x-access-token": "\(token)"]
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
        case .signUp(let parameters),
             .login(let parameters):
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: parameters)
        case .logout:
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: nil)
        }
        print("---- urlRequest: \(urlRequest) ----")
        return urlRequest
    }
}

