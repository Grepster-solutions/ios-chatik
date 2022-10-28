//
//  SignUpPresenter.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

class SignUpPresenter {
    
    // MARK: - Properties
    
    weak var view: SignUpViewController?
    
    
    // MARK: - Methods
    
    func signUp(name: String, email: String, password: String) {
        AuthService.signUp(name: "Daria", email: "prymIzPrilozheniya@mail.ru", password: "123456") { result in
            switch result {
            case .success:
                print("success in signUp")
            case .failure(let error):
                print("error in signUp: ", error.localizedDescription)
            }
        }
    }
}

