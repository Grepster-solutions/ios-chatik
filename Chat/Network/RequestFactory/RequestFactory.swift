//
//  RequestFactory.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import Alamofire

final class RequestFactory {

    private var authFactory: AuthRequestFactory?
    
    lazy private var sessionManager: Session = {
        return SessionManagerFactory.sessionManager
    }()
    
    func makeAuthFactory() -> AuthRequestFactory {
        if let factory = authFactory {
            return factory
        } else {
            let factory = AuthRequestFactory(sessionManager: sessionManager)
            authFactory = factory
            return factory
        }
    }
}

