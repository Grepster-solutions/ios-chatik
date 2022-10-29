//
//  SignInWelcome.swift
//  Chat
//
//  Created by Дарья on 28.10.2022.
//

import UIKit

class SignInWelcome: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = UIColor(named: .darkBlue)
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    private(set) lazy var dictionaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in to your account"
        label.textColor = UIColor(named: .darkBlue)
        label.font = .systemFont(ofSize: 16)
        return label
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
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(helloLabel)
        addSubview(dictionaryLabel)
    }
    
    private func makeConstraints() {
        helloLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        dictionaryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(helloLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
