//
//  NetworkService.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import Foundation


enum NetworkService {
    
    // MARK: - Interface
    
    static func makeRequest<T: Decodable>(requestRouter: AbstractRequestRouter,
                                          modelType: T.Type,
                                          completion: @escaping (Result<T, NetworkError>) -> ()) {
        guard var urlComps = URLComponents(string: NetworkConstants.baseUrl + requestRouter.path) else {
            return
        }
        
        let queryItems = (requestRouter.arguments ?? [:]).map {
            return URLQueryItem(name: $0.key, value: $0.value)
        }
        
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else {
            return
        }
        
        var requestJsonData: Data?
        if let parameters = requestRouter.parameters {
            requestJsonData = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = requestRouter.headers
        urlRequest.httpMethod = requestRouter.method.rawValue
        urlRequest.httpBody = requestJsonData
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(getNetworkError(with: error, response: response)))
                } else if let data = data {
                    do {
                        if modelType is Bool.Type {
                            completion(.success(true as! T))
                        } else {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: data)
                            completion(.success(result))
                        }
                    } catch {
                        completion(.failure(getNetworkError(with: error, response: response)))
                    }
                } else {
                    completion(.failure(.responseError))
                }
            }
        }
        dataTask.resume()
    }
    
    private static func getNetworkError(with error: Error, response: URLResponse?) -> NetworkError {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 400...499:
                if error.localizedDescription == NetworkError.userAlreadyExists.errorMessage {
                    return NetworkError.userAlreadyExists
                } else if error.localizedDescription == NetworkError.invalidToken.errorMessage {
                    return NetworkError.invalidToken
                } else {
                    return NetworkError.responseError
                }
            case 500...599:
                return NetworkError.serverError
            default:
                return NetworkError.serverError
            }
        } else {
            return .responseError
        }
        
    }
    
}
