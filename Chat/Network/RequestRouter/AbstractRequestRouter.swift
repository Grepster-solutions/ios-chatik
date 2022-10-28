//
//  AbstractRequestRouter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import Alamofire

protocol AbstractRequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var fullUrl: URL { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
}

extension AbstractRequestRouter {
    
    var baseUrl: URL {
        let url = Constants.baseUrl
        return URL.init(string: url)!
    }
    
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    func getFullUrl(with query: [URLQueryItem]) -> URL {
        var appUrl = baseUrl.absoluteString
        appUrl.append(path)
        var components = URLComponents(string: appUrl)
        components?.queryItems = query
        
        guard let url = components?.url else { return fullUrl }
        return url
    }
}

