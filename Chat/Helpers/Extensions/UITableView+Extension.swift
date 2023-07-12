//
//  UITableView+Extension.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit
import Foundation


extension UITableView {
    
    func registerCell(type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }
    
    func dequeueCell<T>(withType type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as? T
    }
    
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async {
            let row = self.numberOfRows(inSection:  self.numberOfSections-1) - 1
            let section = self.numberOfSections - 1
            
            guard row > 0 && section > 0 else { return }
            let indexPath = IndexPath(
                row: row,
                section: section)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    private func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections
        && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
}
