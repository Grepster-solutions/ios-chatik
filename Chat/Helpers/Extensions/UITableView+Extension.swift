//
//  UITableView+Extension.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit

extension UITableView {
    
    func registerCell(type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }
    
    func dequeueCell<T>(withType type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as? T
    }
    
}
