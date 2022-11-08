//
//  AuthViewController.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: AuthPresenter
    private var screenType: AuthScreenType {
        didSet {
            updateTitle(screenType: screenType)
        }
    }
    
    private(set) lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private weak var gradientLayer: CAGradientLayer?
    
    private(set) lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "SIGN UP"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "SIGN IN"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var logoView = LogoView()
    private(set) lazy var textFieldsView = TextFieldsView()
    private(set) lazy var mainButtonsView = MainButtonsView()
    
    
    // MARK: - Init
    
    init(presenter: AuthPresenter, screenType: AuthScreenType) {
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
        
        if AuthController.getToken() != nil {
            AppController.shared.openModule(.main)
        }
        
        NotificationCenter.default.addObserver(forName: .didLogout,
                                               object: nil,
                                               queue: .main) { [weak self] _ in
            self?.screenType = .registration
        }
        
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
        
        gradientLayer?.frame = view.bounds
        gradientLayer = backgroundView.makeGradient(colors: [UIColor(named: .purple), UIColor(named: .darkBlue)],
                                                 locations: [0.0, 1.0],
                                                 startPoint: CGPoint(x: 0, y: 0),
                                                 endPoint: CGPoint(x: 1, y: 1))
    }
    
    
    // MARK: - Methods
    
    func removeTextInTextFields() {
        textFieldsView.removeTextInTextField()
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(logoView)
        backgroundView.addSubview(textFieldsView)
        backgroundView.addSubview(mainButtonsView)
    }
    
    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        textFieldsView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(52)
            make.top.equalTo(logoView.snp.bottom).offset(UIScreen.main.bounds.size.height * 0.05)
        }
        
        mainButtonsView.snp.makeConstraints { make in
            make.top.equalTo(textFieldsView.snp.bottom).offset(UIScreen.main.bounds.size.height * 0.1)
            make.left.right.bottom.equalToSuperview().inset(52)
        }
    }
    
    private func addTargets() {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapBackgroundView))
        backgroundView.addGestureRecognizer(gesture)
        
        mainButtonsView.signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        mainButtonsView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        mainButtonsView.createButton.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        mainButtonsView.signInButton.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
    }
    
    private func updateTitle(screenType: AuthScreenType) {
        switch screenType {
        case .registration:
            navigationItem.titleView = signUpLabel
        case .login:
            navigationItem.titleView = signInLabel
        }
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapBackgroundView() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapSignUpButton() {
        guard let name = textFieldsView.nameTextField.text, !name.isEmpty else {
            return showToast(title: "Name is empty!")
        }
        
        guard let email = textFieldsView.emailTextField.text, !email.isEmpty else {
            return showToast(title: "Email is empty!")
        }
        
        guard let password = textFieldsView.passwordTextField.text, !password.isEmpty else {
            return showToast(title: "Password is empty!")
        }
        
        presenter.signUp(name: name,
                          email: email,
                          password: password)
    }
    
    @objc
    private func didTapLoginButton() {
        guard let email = textFieldsView.emailTextField.text, !email.isEmpty else {
            return showToast(title: "Email is empty!")
        }
        
        guard let password = textFieldsView.passwordTextField.text, !password.isEmpty else {
            return showToast(title: "Password is empty!")
        }
        
        presenter.login(email: email, password: password)
    }
    
    @objc
    private func didTapTransitionButton() {
        if screenType == .registration {
            screenType = .login
        } else {
            screenType = .registration
        }
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       options: [.curveEaseInOut]) { [weak self] in
            guard let self = self else { return }
            self.mainButtonsView.updateView(screenType: self.screenType)
            self.textFieldsView.updateView(screenType: self.screenType)
        }
    }
}

