//
//  UserRequestRouter.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit
import Alamofire

public enum UserRequestRouter: AbstractRequestRouter {
    case getCurrentUser
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentUser:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentUser:
            return "/current_user"
        }
    }
    
     var headers: HTTPHeaders {
         guard let token = AuthController.getToken() else {
             return ["Content-Type": "application/json"]
         }
         switch self {
         case .getCurrentUser:
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
        case .getCurrentUser:
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: nil)
        }
        print("---- urlRequest: \(urlRequest) ----")
        return urlRequest
    }
}


