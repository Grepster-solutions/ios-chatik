//
//  SignUpOrInViewController.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import SnapKit

enum ScreenType {
    case registration
    case login
}

class SignUpOrInViewController: UIViewController {
    
    private enum Calculations {
        static let backgroundViewHeight: CGFloat = UIScreen.main.bounds.size.height / 5 * 4
    }
    
    // MARK: - Properties
    
    private let presenter: SignUpOrInPresenter
    private var screenType: ScreenType {
        didSet {
            updateTitle(screenType: screenType)
        }
    }
    
    private(set) lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        return view
    }()
    
    private(set) lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "SIGN UP"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: .darkBlue)
        label.text = "SIGN IN"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var signInWelcomeView = SignInWelcome()
    
    private(set) lazy var textFieldsView = TextFields()
    
    private(set) lazy var confirmSignUpButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(UIColor(named: .darkBlue), for: .normal)
        return button
    }()
    
    private(set) lazy var confirmSignInButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor(named: .darkBlue), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private(set) lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    // MARK: - Init
    
    init(presenter: SignUpOrInPresenter, screenType: ScreenType) {
        self.presenter = presenter
        self.screenType = screenType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        switch screenType {
        case .registration:
            navigationItem.titleView = signUpLabel
        case .login:
            navigationItem.titleView = signInLabel
        }
        
        addSubviews()
        makeConstraints()
        addTargets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var confirmSignUpButtonRadius: CGFloat = confirmSignUpButton.frame.size.height / 2
        var confirmSignInButtonRadius: CGFloat = confirmSignInButton.frame.size.height / 2
        
        backgroundView.setGradient(colors: [UIColor(named: .purple), UIColor(named: .darkBlue)],
                                   locations: [0.0, 1.0],
                                   startPoint: CGPoint(x: 0, y: 0),
                                   endPoint: CGPoint(x: 1, y: 1))
        
        textFieldsView.didLayoutSubviews()
        
        confirmSignUpButton.layer.cornerRadius = confirmSignUpButtonRadius
        confirmSignInButton.layer.cornerRadius = confirmSignInButtonRadius
        
        confirmSignUpButton.setShadowWithColor(color: UIColor(named: .shadowPurple),
                                        opacity: 1,
                                        offset: CGSize(width: 0, height: 0),
                                        radius: confirmSignUpButtonRadius,
                                        viewCornerRadius: confirmSignUpButtonRadius)
        
        confirmSignInButton.setShadowWithColor(color: UIColor(named: .shadowPurple),
                                               opacity: 1,
                                               offset: CGSize(width: 0, height: 0),
                                               radius: confirmSignInButtonRadius,
                                               viewCornerRadius: confirmSignInButtonRadius)
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        view.addSubview(signInWelcomeView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(signUpButton)
        
        backgroundView.addSubview(textFieldsView)
        
        backgroundView.addSubview(confirmSignUpButton)
        backgroundView.addSubview(confirmSignInButton)
        backgroundView.addSubview(signInButton)
    }
    
    private func makeConstraints() {
        signInWelcomeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(Calculations.backgroundViewHeight)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(24)
        }
        
        textFieldsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(54)
        }
        
        
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        confirmSignUpButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(100)
            make.bottom.equalTo(signInButton.snp.top).offset(-30)
            make.height.equalTo(40)
        }
        
        confirmSignInButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(100)
            make.bottom.equalTo(signInButton.snp.top).offset(-30)
            make.height.equalTo(40)
        }
    }
    
    private func addTargets() {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapBackgroundView))
        backgroundView.addGestureRecognizer(gesture)
        
        confirmSignUpButton.addTarget(self, action: #selector(didTapConfirmSignUpButton), for: .touchUpInside)
        
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    private func updateTitle(screenType: ScreenType) {
        switch screenType {
        case .registration:
            navigationItem.titleView = signUpLabel
        case .login:
            navigationItem.titleView = signInLabel
        }
    }
    
    private func updateCorenerRadius(screenType: ScreenType) {
        UIView.animate(withDuration: 0.5,
                       delay: 0, options: [.curveEaseInOut]) { [weak self] in
            guard let self = self else { return }
            switch screenType {
            case .registration:
                self.backgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            case .login:
                self.backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    private func updateTextFields(screenType: ScreenType) {
        var y = Double()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseInOut]) { [weak self] in
            guard let self = self else { return }
            switch screenType {
            case .registration:
                y = UIScreen.main.bounds.height / 5
                print("zzz1 ", y)
                self.textFieldsView.stackView.frame.origin = CGPoint(x: 0, y: -y)
            case .login:
                y = UIScreen.main.bounds.height / 3.2
                print("zzz2 ", y)
                self.textFieldsView.stackView.frame.origin = CGPoint(x: 0, y: -y)
            }
        }
    }
    
    private func hideTextFields(screenType: ScreenType) {
        UIView.animate(withDuration: 0.5,
                       delay: 0, options: [.curveEaseInOut]) { [weak self] in
            self?.textFieldsView.hideView(screenType: screenType)
        }
    }
    
    private func updateSignUpOrInButton(screenType: ScreenType) {
        UIView.animate(withDuration: 0.5,
                       delay: 0, options: [.curveEaseInOut]) { [weak self] in
            guard let self = self else { return }
            switch screenType {
            case .registration:
                self.signUpButton.isHidden = true
                self.signInButton.isHidden = false
                self.confirmSignUpButton.isHidden = false
                self.confirmSignInButton.isHidden = true
            case .login:
                self.signUpButton.isHidden = false
                self.signInButton.isHidden = true
                self.confirmSignUpButton.isHidden = true
                self.confirmSignInButton.isHidden = false
            }
        }
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapBackgroundView() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapConfirmSignUpButton() {
        guard let name = textFieldsView.nameTextField.text, !name.isEmpty else {
            return showToast(title: "Name is Empty!")
        }
        
        guard let email = textFieldsView.emailTextField.text, !email.isEmpty else {
            return showToast(title: "Email is empty!")
        }
        
        guard let password = textFieldsView.passwordTextField.text, !password.isEmpty else {
            return showToast(title: "Password is Empty!")
        }
        
        presenter.signUp(name: name,
                          email: email,
                          password: password)
    }
    
    @objc
    private func didTapSignInButton() {
        let y = UIScreen.main.bounds.height / 4
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.allowAnimatedContent, .curveEaseInOut]) { [weak self] in
            guard let self = self else { return }
            self.screenType = .login
            self.hideTextFields(screenType: .login)
            self.updateTextFields(screenType: .login)
            self.updateSignUpOrInButton(screenType: .login)
            self.backgroundView.frame.origin = CGPoint(x: 0, y: y)
            self.updateCorenerRadius(screenType: .login)
        }
    }
    
    @objc
    private func didTapSignUpButton() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.allowAnimatedContent, .curveEaseInOut]) { [weak self] in
            guard let self = self else { return }
            self.screenType = .registration
            self.hideTextFields(screenType: .registration)
            self.updateTextFields(screenType: .registration)
            self.updateSignUpOrInButton(screenType: .registration)
            self.backgroundView.frame.origin = CGPoint(x: 0, y: 0)
            self.updateCorenerRadius(screenType: .registration)
        }
    }
}

