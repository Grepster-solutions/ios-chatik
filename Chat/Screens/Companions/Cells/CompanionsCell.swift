//
//  CompanionsCell.swift
//  Chat
//
//  Created by Дарья on 06.11.2022.
//

import UIKit
import SnapKit

class CompanionsCell: UITableViewCell {
    
    // MARK: - Properties
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    // MARK: - Overrides
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func display(model: Companion) {
        nameLabel.text = model.name
    }
    
    
    // MARK: - Private methods
    
    private func addSubview() {
        contentView.addSubview(nameLabel)
    }
    
    private func makeConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
        }
    }
}

