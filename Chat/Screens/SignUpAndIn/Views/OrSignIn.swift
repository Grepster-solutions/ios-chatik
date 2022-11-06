//
//  OrSignIn.swift
//  Chat
//
//  Created by Дарья on 28.10.2022.
//

import UIKit

class OrSignIn: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Or sign in with"
        label.textColor = UIColor(named: .darkBlue)
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private(set) lazy var button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: .darkBlue)
        return button
    }()
    
    private(set) lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: .darkBlue)
        return button
    }()
    
    private(set) lazy var button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: .darkBlue)
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
        
        button1.layer.cornerRadius = button1.frame.size.height / 2
        button2.layer.cornerRadius = button2.frame.size.height / 2
        button3.layer.cornerRadius = button3.frame.size.height / 2
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.bottom.equalToSuperview()
        }
        
        button1.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        button2.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        button3.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }
}
