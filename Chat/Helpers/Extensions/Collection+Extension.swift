//
//  Collection+Extension.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import Foundation


extension Collection {
    
    /// Проверка, что коллекция не пустая.
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    /// Возвращает элемент по индексу, иначе nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
