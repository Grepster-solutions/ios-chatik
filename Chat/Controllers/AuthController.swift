//
//  AuthController.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit

final class AuthController {
    private static let serviceTokenName = "TokenService"
    
    class func getToken() -> String? {
        guard let currentUser = UserDefaultsManager.currentUser else {
            print("Не удалось получить токен. Нет юзера от приложения.")
            return nil
        }
        
        do {
            return try KeychainPasswordItem(service: serviceTokenName,
                                            account: currentUser.email).readPassword()
        } catch {
            print("Не получилось прочитать токен. Возможно его просто нет. Значит юзер разлогинен. Ошибка: \(error.localizedDescription)")
            return nil
        }
    }
    
    class func login(with token: String) {
        guard let currentUser = UserDefaultsManager.currentUser else {
            print("Не удалось сохранить токен. Нет юзера от приложения.")
            return
        }
        
        do {
            try KeychainPasswordItem(service: serviceTokenName,
                                     account: currentUser.email).savePassword(token)
        } catch {
            print("Не удалось сохранить токен. Ошибка: \(error.localizedDescription)")
        }
    }
    
    class func logout() {
        try? localLogout()
    }
    
    private class func localLogout() throws {
        guard let currentUser = UserDefaultsManager.currentUser else { return }
        try KeychainPasswordItem(service: serviceTokenName,
                                 account: currentUser.email).deleteItem()
        UserDefaultsManager.currentUser = nil
        AppController.openModule(.auth(.login))
    }
}

