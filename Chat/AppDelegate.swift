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
        window?.makeKeyAndVisible()
        startApp()
        return true
    }
    
    private func startApp() {
        if UserDefaultsManager.currentUser != nil {
            AppController.openModule(.chatList)
        } else {
            AppController.openModule(.auth(.login))
        }
    }
}

