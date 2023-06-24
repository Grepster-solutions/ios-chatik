//
//  UsersForChatItemCell.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit


final class UsersForChatItemCell: UITableViewCell {
    
    // MARK: - Model
    
    struct Model {
        let userName: String
    }
    
    
    // MARK: - Properties
    
    let nameLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Interface
    
    func setup(with model: Model) {
        nameLabel.text = model.userName
    }
    
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        }
    }
    
}
