//
//  AbstractRequestFactory.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import Alamofire

protocol AbstractRequestFactory {
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request(_ request: URLRequestConvertible) -> DataRequest
    
    @discardableResult
    func uploadMultipartFormData(_ request: URLRequestConvertible) -> DataRequest?
    
    @discardableResult
    func downloadFile(_ request: URLRequestConvertible) -> DownloadRequest
}

extension AbstractRequestFactory {
    @discardableResult
    func request(_ request: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(request)
    }
    
    @discardableResult
    func uploadMultipartFormData(_ request: URLRequestConvertible) -> DataRequest? {
        guard let request = try? request.asURLRequest(),
              let url = request.url,
              let parametersData = request.httpBody,
              let parameters = try? JSONSerialization.jsonObject(with: parametersData, options: []) as? [String: Any] else { return nil }
        
        let multipartFormData = MultipartFormData()
        parameters.forEach { key, value in
            if let valueString = value as? String {
                if let valueURL = URL(string: valueString) {
                    multipartFormData.append(valueURL, withName: key)
                } else if let data = valueString.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
                return
            }
        }
        
        return sessionManager.upload(multipartFormData: multipartFormData, to: url, headers: request.headers)
    }
    
    @discardableResult
    func downloadFile(_ request: URLRequestConvertible) -> DownloadRequest {
        return sessionManager.download(request)
    }
}

