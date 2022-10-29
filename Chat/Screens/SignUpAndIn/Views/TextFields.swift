//
//  TextFields.swift
//  Chat
//
//  Created by Дарья on 28.10.2022.
//

import UIKit
import SnapKit

class TextFields: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private(set) lazy var nameContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User name"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter your name"
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textContentType = .name
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private(set) lazy var emailContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter your email"
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private(set) lazy var passwordContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Сreate a password"
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textContentType = .newPassword
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private(set) lazy var repeatPasswordContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat password"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Repeat password"
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
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
    
    
    // MARK: - Methods
    
    func didLayoutSubviews() {
        nameTextField.layer.cornerRadius = nameTextField.frame.size.height / 2
        emailTextField.layer.cornerRadius = emailTextField.frame.size.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height / 2
        repeatPasswordTextField.layer.cornerRadius = repeatPasswordTextField.frame.size.height / 2
        
        nameTextField.setLeftPaddingPoints(nameTextField.frame.size.height / 2)
        emailTextField.setLeftPaddingPoints(emailTextField.frame.size.height / 2)
        passwordTextField.setLeftPaddingPoints(passwordTextField.frame.size.height / 2)
        repeatPasswordTextField.setLeftPaddingPoints(repeatPasswordTextField.frame.size.height / 2)
    }
    
    func hideView(screenType: ScreenType) {
        switch screenType {
        case .registration:
            nameContainer.isHidden = false
            repeatPasswordContainer.isHidden = false
        case .login:
            nameContainer.isHidden = true
            repeatPasswordContainer.isHidden = true
        }
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameContainer)
        nameContainer.addSubview(nameLabel)
        nameContainer.addSubview(nameTextField)
        
        stackView.addArrangedSubview(emailContainer)
        emailContainer.addSubview(emailLabel)
        emailContainer.addSubview(emailTextField)
        
        stackView.addArrangedSubview(passwordContainer)
        passwordContainer.addSubview(passwordLabel)
        passwordContainer.addSubview(passwordTextField)
        
        stackView.addArrangedSubview(repeatPasswordContainer)
        repeatPasswordContainer.addSubview(repeatPasswordLabel)
        repeatPasswordContainer.addSubview(repeatPasswordTextField)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
}
