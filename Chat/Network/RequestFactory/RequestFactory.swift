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
    private var userFactory: UserRequestFactory?
    
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
    
    func makeUserFactory() -> UserRequestFactory {
        if let factory = userFactory {
            return factory
        } else {
            let factory = UserRequestFactory(sessionManager: sessionManager)
            userFactory = factory
            return factory
        }
    }
}

