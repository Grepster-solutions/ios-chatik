//
//  SignUpOrInPresenter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

class SignUpOrInPresenter {
    
    // MARK: - Properties
    
    weak var view: SignUpOrInViewController?
    
    
    // MARK: - Methods
    
    func signUp(name: String, email: String, password: String) {
        AuthService.signUp(name: name, email: email, password: password) { [weak view] result in
            switch result {
            case .success(let data):
                view?.showAlert(alertText: "Успех!", alertMessage: "\(data.token)")
                view?.removeTextInTextFields()
//                AuthController.login(with: data.token)
                print("success in signUp")
            case .failure(let error):
                view?.showAlert(alertText: "Не вышло:(", alertMessage: "В другой раз получится!")
                print("error in signUp: ", error.localizedDescription)
            }
        }
    }
    
    func login(email: String, password: String) {
        AuthService.login(email: email, password: password) { [weak view] result in
            switch result {
            case .success(let data):
                view?.showAlert(alertText: "Успех!", alertMessage: "\(data.token)")
                view?.removeTextInTextFields()
//                AuthController.login(with: data.token)
                print("success in login")
            case .failure(let error):
                view?.showAlert(alertText: "Не вышло:(", alertMessage: "В другой раз получится!")
                print("error in login: ", error.localizedDescription)
            }
        }
    }
}

