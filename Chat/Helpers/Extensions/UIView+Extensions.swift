//
//  UIView+Extensions.swift
//  Chat
//
//  Created by Дарья on 28.10.2022.
//

import UIKit

extension UIView {
    
    /// Установка градиента для любого UIView
    func makeGradient(colors: [UIColor],
                      locations: [NSNumber],
                      startPoint: CGPoint,
                      endPoint: CGPoint) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    /// Установка тени для любого UIView
    func setShadowWithColor(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat?, viewCornerRadius: CGFloat?) {
        layer.masksToBounds = false
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius ?? 0
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: viewCornerRadius ?? 0.0).cgPath
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
}
