//
//  UIView+Create.swift
//  Chat
//
//  Created by Vladislav on 27.06.2023.
//

import UIKit


extension UIView {
    
    static func create<T: UIView>(configure: Closure<T>) -> T {
        let view = T()
        configure(view)
        return view
    }
    
}
