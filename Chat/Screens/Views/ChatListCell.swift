//
//  ChatListCell.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import UIKit

class ChatListCell: UITableViewCell {
    //
    let logoImageView = UIImageView()
    let messageLabel = UILabel()
    let timeLabel = UILabel()
    let nameLabel = UILabel()
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
    
    func setup(message: String?, time: Int?, name: String, logoUrl: URL?) {
        messageLabel.text = message
        timeLabel.text = "22:35"
        nameLabel.text = name
        logoImageView.backgroundColor = .green
    }
    
    private func setupLayout() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(nameLabel)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 14),
            nameLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: -12),
            
            messageLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 14),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -14)
        ])
        
    }
    
}
