//
//  ChatViewController.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import UIKit
import ReverseExtension


protocol ChatView: UIViewController {
    
    // MARK: - Protocol
    
    func setTableService(_ tableService: ChatTableService)
    func reloadData()
    
}


final class ChatViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: ChatPresenter
    private var messageType: MessageType?
    private var messageContentType: MessageContentType?
    
    private lazy var backgroundView = UIView()
    private weak var gradientLayer: CAGradientLayer?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(type: IncomingMessageCell.self)
        tableView.registerCell(type: OutcomingMessageCell.self)
        tableView.registerCell(type: SystemMessageCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.backgroundView = backgroundView
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    private lazy var messagePanel: MessagePanel = {
        let messagePanel = MessagePanel()
        messagePanel.delegate = presenter as? MessagePanelDelegate
        return messagePanel
    }()
    
    
    // MARK: - Init
    
    init(presenter: ChatPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        presenter.start()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer?.frame = view.bounds
        gradientLayer = backgroundView.makeGradient(colors: [UIColor(named: .purple).withAlphaComponent(0.4),
                                                             UIColor(named: .darkBlue).withAlphaComponent(0.4)],
                                                    locations: [0.0, 1.0],
                                                    startPoint: CGPoint(x: 0, y: 0),
                                                    endPoint: CGPoint(x: 1, y: 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisappear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(messagePanel)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        messagePanel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func keyboardWillAppear(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = -keyboardSize.height
        }
    }
    
    @objc
    private func keyboardWillDisappear(_ notification: NSNotification) {
        view.frame.origin.y = .zero
    }
    
}

extension ChatViewController: ChatView {
    
    // MARK: - ChatView
    
    func setTableService(_ tableService: ChatTableService) {
        tableView.re.delegate = tableService
        tableView.re.dataSource = tableService
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}
