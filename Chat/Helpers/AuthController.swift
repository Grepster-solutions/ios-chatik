//
//  AuthController.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit

public final class AuthController {
    static let serviceTokenName = "TokenService"
    
    public class func getToken() -> String? {
        guard let currentUser = Settings.currentUser else {
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
    
    public class func login(with token: String) {
        guard let currentUser = Settings.currentUser else {
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
    
    public class func signOut() {
//        AuthService.logout { result in
//            switch result {
//            case .success:
//                guard ((try? localSignOut()) != nil) else {
//                    print("local logout failure")
//                    return
//                }
//
//                print("logout success")
//            case .failure(let error):
//                print("logout failure with error: ", error.localizedDescription)
//            }
//        }
    }
    
    public class func localSignOut() throws {
//        guard let currentUser = Settings.currentUser else { return }
//        try KeychainPasswordItem(service: serviceTokenName,
//                                 account: currentUser.email).deleteItem()
//        NotificationCenter.default.post(name: .didLogout, object: nil)
    }
}

