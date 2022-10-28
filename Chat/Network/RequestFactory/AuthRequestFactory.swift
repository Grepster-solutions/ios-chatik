//
//  AuthRequestFactory.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import Alamofire

final class AuthRequestFactory: AbstractRequestFactory {
    var sessionManager: Session
    var queue: DispatchQueue
    
    init(sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)) {
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
    public func sendRequest<T>(
        modelType: T.Type,
        requestOptions: AuthRequestRouter,
        completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        self.request(requestOptions).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                if case let .failure(error) = response.result, let urlError = error.underlyingError as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        completion(.failure(NetworkError.internetError))
                    case URLError.Code.init(rawValue: -1020):
                        completion(.failure(NetworkError.internetError))
                    default:
                        completion(.failure(NetworkError.serverError))
                    }
                } else {
                    completion(.failure(NetworkError.serverError))
                }
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(modelType.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                    return
                }
                completion(.failure(NetworkError.responseError))
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.serverError))
            }
        }
    }
    
    public func sendRequest(
        requestOptions: AuthRequestRouter,
        completion: @escaping (Result<Bool, Error>) -> Void) {
        self.request(requestOptions).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                if case let .failure(error) = response.result, let urlError = error.underlyingError as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        completion(.failure(NetworkError.internetError))
                    case URLError.Code.init(rawValue: -1020):
                        completion(.failure(NetworkError.internetError))
                    default:
                        completion(.failure(NetworkError.serverError))
                    }
                } else {
                    completion(.failure(NetworkError.serverError))
                }
                return
            }
            switch statusCode {
            case 200 ... 399:
                completion(.success(true))
            case 400...499:
                completion(.failure(NetworkError.responseError))
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.serverError))
            }
        }
    }
}

