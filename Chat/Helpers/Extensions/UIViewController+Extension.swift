//
//  UIViewController+Extension.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

extension UIViewController {
    //Show a basic alert
    func showAlert(alertText: String, alertMessage: String? = "") {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle:  UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        //Add more actions as you see fit
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(title: String, message: String? = "") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
