//
//  TextFieldsView.swift
//  Chat
//
//  Created by Дарья on 28.10.2022.
//

import UIKit
import SnapKit

class TextFieldsView: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private(set) lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        textField.textColor = .white
        textField.textContentType = .name
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        textField.textColor = .white
        textField.textContentType = .emailAddress
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        textField.textColor = .white
        textField.textContentType = .newPassword
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private(set) lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Repeat password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        textField.textColor = .white
        textField.textContentType = .newPassword
        textField.autocorrectionType = .no
        return textField
    }()
    
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameTextField.setLeftPaddingPoints(nameTextField.frame.size.height / 2)
        emailTextField.setLeftPaddingPoints(emailTextField.frame.size.height / 2)
        passwordTextField.setLeftPaddingPoints(passwordTextField.frame.size.height / 2)
        repeatPasswordTextField.setLeftPaddingPoints(repeatPasswordTextField.frame.size.height / 2)
        
        nameTextField.setUnderLine()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        repeatPasswordTextField.setUnderLine()
    }
    
    
    
    // MARK: - Methods
    
    func updateView(screenType: ScreenType) {
        switch screenType {
        case .registration:
            nameTextField.isHidden = false
            repeatPasswordTextField.isHidden = false
        case .login:
            nameTextField.isHidden = true
            repeatPasswordTextField.isHidden = true
        }
    }
    
    func removeTextInTextField() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(repeatPasswordTextField)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
}
