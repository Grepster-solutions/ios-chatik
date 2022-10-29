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
        AuthService.signUp(name: name, email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.view?.showAlert(alertText: "Успех!", alertMessage: "")
                print("success in signUp")
            case .failure(let error):
                self?.view?.showAlert(alertText: "Не вышло:(", alertMessage: "В другой раз получится!")
                print("error in signUp: ", error.localizedDescription)
            }
        }
    }
}

