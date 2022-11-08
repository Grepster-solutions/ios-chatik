//
//  AuthPresenter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

class AuthPresenter {
    
    // MARK: - Properties
    
    weak var view: AuthViewController?
    
    
    // MARK: - Methods
    
    func signUp(name: String, email: String, password: String) {
        AuthService.signUp(name: name, email: email, password: password) { [weak self, weak view] result in
            guard let self = self, let view = view else { return }
            switch result {
            case .success(let data):
                self.resultSuccess(data)
                print("success in signUp")
            case .failure(let error):
                view.showAlert(alertText: "Не вышло:(", alertMessage: "В другой раз получится!")
                print("error in signUp: ", error.localizedDescription)
            }
        }
    }
    
    func login(email: String, password: String) {
        AuthService.login(email: email, password: password) { [weak self, weak view] result in
            guard let self = self, let view = view else { return }
            switch result {
            case .success(let data):
                self.resultSuccess(data)
                print("success in login")
            case .failure(let error):
                view.showAlert(alertText: "Не вышло:(", alertMessage: "В другой раз получится!")
                print("error in login: ", error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Private methods
    
    private func resultSuccess(_ data: AuthenticationResult) {
        view?.removeTextInTextFields()
        UserDefaultsManager.currentUser = data.user
        AuthController.login(with: data.token)
        AppController.shared.openModule(.main)
    }
}

