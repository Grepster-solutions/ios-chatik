//
//  IncomingMessageCell.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import UIKit
import SnapKit

class IncomingMessageCell: UITableViewCell {
    
    // MARK: - Properties
    
    private(set) lazy var messageView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private(set) lazy var incomingTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private weak var gradientLayer: CAGradientLayer?
    
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
    }
    
    
    // MARK: - Methods
    
    func display(model: Message) {
        incomingTextLabel.text = model.text
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        dateLabel.text = "\(formatter.string(from: Date()))"
    }
    
    // MARK: - Private methods
    
    private func addSubview() {
        contentView.addSubview(messageView)
        messageView.addSubview(incomingTextLabel)
        contentView.addSubview(dateLabel)
        
        gradientLayer = messageView.makeGradient(colors: [UIColor(named: .purple), UIColor(named: .darkBlue)],
                                                 locations: [0.0, 1.0],
                                                 startPoint: CGPoint(x: 0, y: 0),
                                                 endPoint: CGPoint(x: 1, y: 1))
    }
    
    private func makeConstraints() {
        messageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.right.lessThanOrEqualToSuperview().inset(UIScreen.main.bounds.size.width * 0.2)
            make.height.greaterThanOrEqualTo(40)
        }
        
        incomingTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(messageView.snp.right).offset(8)
        }
    }
}
