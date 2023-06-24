//
//  AbstractRequestRouter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case query = "QUERY"
    case trace = "TRACE"
}

typealias HTTPHeaders = [String: String]
typealias HTTPParameters = [String: Any]

protocol AbstractRequestRouter {
    var path: String { get }
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var parameters: HTTPParameters? { get }
}

