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
    
    var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "\(Constants.apiVersion)/signup"
        }
    }
    
     var headers: HTTPHeaders {
        switch self {
        case .signUp:
            return ["Content-Type": "application/json"]
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
        case .signUp(let parameters):
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: parameters)
        }
        print("---- urlRequest: \(urlRequest) ----")
        return urlRequest
    }
}

