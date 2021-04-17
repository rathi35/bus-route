//
//  UIViewExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//
import  UIKit

extension UIView {
    @objc func setShadow(color: UIColor = UIColor.lightGray, radius: CGFloat = 4) {
        
        layer.cornerRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
}
