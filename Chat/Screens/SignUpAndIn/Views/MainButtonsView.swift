//
//  MainButtonsView.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit
import SnapKit

class MainButtonsView: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(named: .darkBlue), for: .normal)
        return button
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(named: .darkBlue), for: .normal)
        return button
    }()
    
    private(set) lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.text = "Do you have an account?"
        label.layer.zPosition = 2
        return label
    }()
    
    private(set) lazy var createButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white.withAlphaComponent(0.9)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor(named: .darkBlue), for: .normal)
        return button
    }()
    
    private(set) lazy var signInButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .white.withAlphaComponent(0.9)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(named: .darkBlue), for: .normal)
        return button
    }()
    
    
    // MARK: - Overrides
    
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
        
        let loginButtonRadius = loginButton.frame.size.height / 2
        let signUpButtonRadius = signUpButton.frame.size.height / 2
        let createButtonRadius = createButton.frame.size.height / 2
        let signInButtonRadius = signInButton.frame.size.height / 2
        
        loginButton.layer.cornerRadius = loginButtonRadius
        signUpButton.layer.cornerRadius = signUpButtonRadius
        createButton.layer.cornerRadius = createButtonRadius
        signInButton.layer.cornerRadius = signInButtonRadius
        
        loginButton.setShadowWithColor(color: UIColor(named: .shadowPurple),
                                            opacity: 1,
                                            offset: CGSize(width: 0, height: 0),
                                            radius: loginButtonRadius,
                                            viewCornerRadius: loginButtonRadius)
        
        signUpButton.setShadowWithColor(color: UIColor(named: .shadowPurple),
                                            opacity: 1,
                                            offset: CGSize(width: 0, height: 0),
                                            radius: signUpButtonRadius,
                                            viewCornerRadius: signUpButtonRadius)
        
        createButton.setShadowWithColor(color: UIColor(named: .shadowPurple),
                                            opacity: 1,
                                            offset: CGSize(width: 0, height: 0),
                                            radius: createButtonRadius,
                                            viewCornerRadius: createButtonRadius)
        
        signInButton.setShadowWithColor(color: UIColor(named: .shadowPurple),
                                            opacity: 1,
                                            offset: CGSize(width: 0, height: 0),
                                            radius: signInButtonRadius,
                                            viewCornerRadius: signInButtonRadius)
    }
    
    
    // MARK: - Methods
    
    func updateView(screenType: ScreenType) {
        switch screenType {
        case .registration:
            loginButton.isHidden = true
            signUpButton.isHidden = false
            createButton.isHidden = true
            signInButton.isHidden = false
            questionLabel.text = "Do you have an account?"
        case .login:
            loginButton.isHidden = false
            signUpButton.isHidden = true
            createButton.isHidden = false
            signInButton.isHidden = true
            questionLabel.text = "Don’t have an account?"
        }
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(loginButton)
        addSubview(signUpButton)
        addSubview(questionLabel)
        addSubview(createButton)
        addSubview(signInButton)
    }
    
    private func makeConstraints() {
        loginButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(createButton.snp.top).offset(-10)
        }
        
        createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width / 3)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width / 3)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
    }
}
