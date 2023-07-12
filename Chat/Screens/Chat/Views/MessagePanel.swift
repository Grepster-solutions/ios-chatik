//
//  MessagePanel.swift
//  Chat
//
//  Created by Vladislav on 25.06.2023.
//

import UIKit

protocol MessagePanelDelegate: AnyObject {
    
    // MARK: - Protocol
    
    func didChangeText(newText: String)
    func didTapSendButton()
    
}


final class MessagePanel: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let minInputHeight: CGFloat = 40
        static let buttonSize: CGFloat = 50
        static let buttonInsets: CGFloat = 2
        static let insets: CGFloat = 12
        static let bottomInset: CGFloat = UIScreen.safeInsets.bottom + insets
    }
    
    
    // MARK: - Properties
    
    weak var delegate: MessagePanelDelegate?
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        return textView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("S", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        addSubview(textView)
        addSubview(button)
        
        textView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(Constants.insets)
            make.bottom.equalToSuperview().offset(-Constants.bottomInset)
            make.right.equalTo(button.snp.left).offset(-Constants.insets)
            make.height.equalTo(Constants.minInputHeight).priority(.medium)
        }
        
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-Constants.buttonInsets)
            make.size.equalTo(Constants.buttonSize)
            make.top.equalToSuperview().offset(Constants.buttonInsets)
        }
    }
    
    
    // MARK: - User Actions
    
    @objc
    private func buttonTapped() {
        delegate?.didTapSendButton()
        textView.text = ""
    }
    
}

extension MessagePanel: UITextViewDelegate {
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.didChangeText(newText: textView.text)
    }
    
}
