//
//  AppController.swift
//  Chat
//
//  Created by Дарья on 01.11.2022.
//

import UIKit

enum ScreenType {
    case auth(AuthScreenType)
    case chatList
}

enum AuthScreenType {
    case registration
    case login
}

final class AppController {
    
    private static let shared = AppController()
    
    private var window: UIWindow? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first
    }
    
    private var rootViewController: UIViewController? {
        didSet {
            if let vc = rootViewController {
                window?.rootViewController = vc
            }
        }
    }
    
    
    static func openModule(_ type: ScreenType) {
        shared._openModule(type)
    }
    
    private func _openModule(_ type: ScreenType) {
        switch type {
        case .auth(.registration):
            let presenter = AuthPresenter()
            let vc = AuthViewController(presenter: presenter, screenType: .registration)
            presenter.view = vc
            rootViewController = UINavigationController(rootViewController: vc)
        case .auth(.login):
            let presenter = AuthPresenter()
            let vc = AuthViewController(presenter: presenter, screenType: .login)
            presenter.view = vc
            rootViewController = UINavigationController(rootViewController: vc)
        case .chatList:
            let router = ChatListRouterImpl()
            let presenter = ChatListPresenterImpl(router: router)
            let vc = ChatListViewController(presenter: presenter)
            presenter.view = vc
            router.view = vc
            rootViewController = UINavigationController(rootViewController: vc)
        }
    }
}

