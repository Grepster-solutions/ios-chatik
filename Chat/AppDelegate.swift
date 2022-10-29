//
//  AppDelegate.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootController = UINavigationController(rootViewController: makeRootView())
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        return true
    }

    private func makeRootView() -> UIViewController {
        let presenter = SignUpOrInPresenter()
        let view = SignUpOrInViewController(presenter: presenter, screenType: .registration)
        presenter.view = view
        return view
    }
}

