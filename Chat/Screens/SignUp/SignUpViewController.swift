//
//  SignUpViewController.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: SignUpPresenter
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var nameTextField: UITextField = {
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
    
    private var emailTextField: UITextField = {
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
    
    private var passwordTextField: UITextField = {
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
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var animationContainerView: UIView!
    
    
    // MARK: - Init
    
    init(presenter: SignUpPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        makeConstraints()
        addTargets()
        
        animationContainerView = UIView(frame: view.bounds)
          animationContainerView.frame = view.bounds
          view.addSubview(animationContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height / 2
        nameTextField.layer.cornerRadius = nameTextField.frame.size.height / 2
        emailTextField.layer.cornerRadius = nameTextField.frame.size.height / 2
        passwordTextField.layer.cornerRadius = nameTextField.frame.size.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      //create new view
        let newView = UIView()
        newView.backgroundColor = .red
      newView.center = animationContainerView.center

      //add the new view via transition
      UIView.transition(with: animationContainerView,
        duration: 0.33,
        options: [.curveEaseOut, .transitionFlipFromBottom],
        animations: {
          self.animationContainerView.addSubview(newView)
        },
        completion: nil
      )
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(signUpButton)
        backgroundView.addSubview(stackView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
    }
    
    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(700)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    private func addTargets() {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapBackgroundView))
        backgroundView.addGestureRecognizer(gesture)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapBackgroundView() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapSignUpButton() {
        guard let name = nameTextField.text, !name.isEmpty else {
            print("name is Empty!")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is Empty!")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("password is Empty!")
            return
        }
        
        presenter.signUp(name: name,
                         email: email,
                         password: password)
    }
}

