//
//  LogoView.swift
//  Chat
//
//  Created by Дарья on 31.10.2022.
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: .darkBlue)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var appName: UILabel = {
        let label = UILabel()
        label.text = "CHAT"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
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
        addSubview(logoImageView)
        addSubview(appName)
    }
    
    private func makeConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(UIScreen.main.bounds.size.width / 4)
            make.top.left.right.equalToSuperview()
        }
        
        appName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
