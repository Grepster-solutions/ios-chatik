//
//  OutcomingMessageCell.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import UIKit
import SnapKit

class OutcomingMessageCell: UITableViewCell {
    
    // MARK: - Properties
    
    private(set) lazy var messageView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: .lightBlue)
        return view
    }()
    
    private(set) lazy var outcomingTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
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
    
    func display(model: Message) {
        outcomingTextLabel.text = model.text
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        dateLabel.text = "\(formatter.string(from: Date()))"
    }
    
    
    // MARK: - Private methods
    
    private func addSubview() {
        contentView.addSubview(messageView)
        messageView.addSubview(outcomingTextLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func makeConstraints() {
        messageView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(10)
            make.left.greaterThanOrEqualToSuperview().offset(UIScreen.main.bounds.size.width * 0.2)
            make.height.greaterThanOrEqualTo(40)
        }
        
        outcomingTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(messageView.snp.left).offset(-8)
        }
    }
}

